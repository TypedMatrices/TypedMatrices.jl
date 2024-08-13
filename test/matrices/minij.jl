# constructors
@test allequal([
    Minij(5),
    Minij{Int}(5),
])

# linear algebra functions
run_test_linearalgrbra_functions(Minij.(1:5))

# eltype
@test test_matrix_elements(Minij{Int32}(5))

# content
@test Minij(5) ≈ [1 1 1 1 1; 1 2 2 2 2; 1 2 3 3 3; 1 2 3 4 4; 1 2 3 4 5]
