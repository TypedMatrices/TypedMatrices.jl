# constructors
@test allequal([
    Hadamard(4),
    Hadamard{Int}(4),
])

# linear algebra functions
run_test_linear_algebra_functions(Hadamard.((2) .^ (1:4)))
run_test_properties(Hadamard, [4,8,16,32])

# eltype
@test test_matrix_elements(Hadamard{Int32}(4))

# content
@test Hadamard(4) ≈ [1 1 1 1; 1 -1 1 -1; 1 1 -1 -1; 1 -1 -1 1]
@test Hadamard(8) ≈ [1 1 1 1 1 1 1 1; 1 -1 1 -1 1 -1 1 -1; 1 1 -1 -1 1 1 -1 -1; 1 -1 -1 1 1 -1 -1 1; 1 1 1 1 -1 -1 -1 -1; 1 -1 1 -1 -1 1 -1 1; 1 1 -1 -1 -1 -1 1 1; 1 -1 -1 1 -1 1 1 -1]
