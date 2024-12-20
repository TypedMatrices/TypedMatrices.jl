# constructors
@test allequal([
    Toeplitz(5),
    Toeplitz{Int}(5),
    Toeplitz([1:5;]),
    Toeplitz([1:5;], [1:5;]),
])

# linear algebra functions
run_test_linear_algebra_functions(Toeplitz.(1:5))

# eltype
@test test_matrix_elements(Toeplitz{Int32}(5))

# content
@test Toeplitz(5) ≈ [1 2 3 4 5; 2 1 2 3 4; 3 2 1 2 3; 4 3 2 1 2; 5 4 3 2 1]
@test Toeplitz([1, 2, 3, 4], [1, 4, 5, 6]) ≈ [1 4 5 6; 2 1 4 5; 3 2 1 4; 4 3 2 1]
