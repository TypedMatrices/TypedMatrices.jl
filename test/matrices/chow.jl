# constructors
@test allequal([
    Chow(5),
    Chow(5, 1, 0),
    Chow{Int}(5),
    Chow{Int}(5, 1, 0),
])

# linear algebra functions
test_linearalgrbra_functions([Chow.(1:5); Chow.(1:5, 2, 3)])

# eltype
@test test_matrix_elements(Chow{Int32}(5))

# content
@test Chow(5) ≈ [1 1 0 0 0; 1 1 1 0 0; 1 1 1 1 0; 1 1 1 1 1; 1 1 1 1 1]
@test Chow(5, 2, 0) ≈ [2 1 0 0 0; 4 2 1 0 0; 8 4 2 1 0; 16 8 4 2 1; 32 16 8 4 2]
@test Chow(5, 1, 2) ≈ [3 1 0 0 0; 1 3 1 0 0; 1 1 3 1 0; 1 1 1 3 1; 1 1 1 1 3]
@test Chow(5, 3, 2) ≈ [5 1 0 0 0; 9 5 1 0 0; 27 9 5 1 0; 81 27 9 5 1; 243 81 27 9 5]
