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

# list_matrices
matrices = list_matrices()
@test isa(matrices, Vector)
@test all(isa.(matrices, Type))
@test_throws ArgumentError list_matrices(:notexists)
@test_throws ArgumentError list_matrices(Property(:notexists))
@test_throws ArgumentError list_matrices(Group(:notexists))

# list_matrices filtering
@properties Matrix [:symmetric, :inverse]
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