BUILTIN_GROUP = Group(:builtin)
USER_GROUP = Group(:user)
TEST_GROUP = Group(:test)

# list_groups
groups = list_groups()
@test isa(groups, Vector)
@test all(isa.(groups, Group))
@test BUILTIN_GROUP ∈ groups && USER_GROUP ∈ groups

# add_to_groups
add_to_groups(Matrix, USER_GROUP)
@test Matrix ∈ list_matrices(USER_GROUP)
@test_throws ArgumentError add_to_groups(Matrix, BUILTIN_GROUP)

# add_to_groups alternative interfaces
@test isnothing(add_to_groups(Matrix, USER_GROUP, TEST_GROUP))
@test isnothing(add_to_groups(Matrix, [USER_GROUP, TEST_GROUP]))
@test isnothing(add_to_groups(Matrix, :user, :test))
@test isnothing(add_to_groups(Matrix, [:user, :test]))

# add_to_groups cleanup
remove_from_all_groups(Matrix)

# remove_from_group
add_to_groups(Matrix, USER_GROUP)
remove_from_group(Matrix, USER_GROUP)
@test Matrix ∉ list_matrices(USER_GROUP)
@test_throws ArgumentError remove_from_group(Matrix, BUILTIN_GROUP)
@test_throws ArgumentError remove_from_group(Matrix, USER_GROUP)
@test_throws ArgumentError remove_from_group(Matrix, Group(:notexists))

# remove_from_group alternative interfaces
add_to_groups(Matrix, USER_GROUP)
remove_from_group(Matrix, :user)
@test Matrix ∉ list_matrices(USER_GROUP)

# remove_from_all_groups
add_to_groups(Matrix, USER_GROUP, TEST_GROUP)
add_to_groups(Tridiagonal, USER_GROUP, TEST_GROUP)
remove_from_all_groups(Matrix)
@test Matrix ∉ list_matrices(USER_GROUP)
@test Matrix ∉ list_matrices(TEST_GROUP)
remove_from_all_groups(Tridiagonal)

# save_group
add_to_groups(Matrix, USER_GROUP)
save_group(USER_GROUP, "user.txt")
save_group(:user, "user.txt")
@test isfile("user.txt")
@test_throws ArgumentError save_group(Group(:notexists), "notexists.txt")
rm("user.txt")

# load_group
add_to_groups(Matrix, USER_GROUP)
save_group(USER_GROUP, "user.txt")
load_group(TEST_GROUP, "user.txt")
@test Matrix ∈ list_matrices(TEST_GROUP)
remove_from_group(Matrix, TEST_GROUP)
load_group(:test, "user.txt")
@test Matrix ∈ list_matrices(TEST_GROUP)
remove_from_all_groups(Matrix)
@test_throws ArgumentError load_group(BUILTIN_GROUP, "user.txt")
open("user.txt", "w") do io
    write(io, "MatrixNotExists")
end
@suppress_err @test_throws UndefVarError load_group(USER_GROUP, "user.txt")
rm("user.txt")

# list_matrices
matrices = list_matrices()
@test isa(matrices, Vector)
@test all(isa.(matrices, Type))
@test_throws ArgumentError list_matrices(:notexists)
@test_throws ArgumentError list_matrices(Property(:notexists))
@test_throws ArgumentError list_matrices(Group(:notexists))

# list_matrices filtering
@suppress_err @properties Matrix [:symmetric, :inverse]
add_to_groups(Matrix, USER_GROUP, TEST_GROUP)
@test Matrix ∉ list_matrices(:posdef)
@test Matrix ∈ list_matrices(:symmetric)
@test Matrix ∈ list_matrices(:inverse)
@test Matrix ∈ list_matrices(:symmetric, :inverse)
@test Matrix ∉ list_matrices(:symmetric, :inverse, :posdef)
@test Matrix ∉ list_matrices(BUILTIN_GROUP)
@test Matrix ∈ list_matrices(USER_GROUP)
@test Matrix ∈ list_matrices(TEST_GROUP)
@test Matrix ∈ list_matrices(USER_GROUP, TEST_GROUP)
@test Matrix ∉ list_matrices(BUILTIN_GROUP, USER_GROUP, TEST_GROUP)

# list_matrices alternative interfaces
@test Matrix ∈ list_matrices(Property(:symmetric), Property(:inverse))
@test Matrix ∈ list_matrices([Property(:symmetric), Property(:inverse)])
@test Matrix ∈ list_matrices(:symmetric, :inverse)
@test Matrix ∈ list_matrices([:symmetric, :inverse])
@test Matrix ∈ list_matrices(PropertyTypes.Symmetric, PropertyTypes.Inverse)
@test Matrix ∈ list_matrices([PropertyTypes.Symmetric, PropertyTypes.Inverse])
@test Matrix ∈ list_matrices(PropertyTypes.Symmetric(), PropertyTypes.Inverse())
@test Matrix ∈ list_matrices([PropertyTypes.Symmetric(), PropertyTypes.Inverse()])
@test Matrix ∈ list_matrices(USER_GROUP, TEST_GROUP)
@test Matrix ∈ list_matrices([USER_GROUP, TEST_GROUP])
