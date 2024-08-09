# constructors
@test allequal([
    Hadamard(4),
    Hadamard{Int}(4),
])

# linear algebra functions
test_linearalgrbra_functions(Hadamard.((2) .^ (1:4)))

# eltype
@test test_matrix_elements(Hadamard{Int32}(4))

# content
@test Hadamard(4) ≈ [1 1 1 1; 1 -1 1 -1; 1 1 -1 -1; 1 -1 -1 1]
@test Hadamard(8) ≈ [1 1 1 1 1 1 1 1; 1 -1 1 -1 1 -1 1 -1; 1 1 -1 -1 1 1 -1 -1; 1 -1 -1 1 1 -1 -1 1; 1 1 1 1 -1 -1 -1 -1; 1 -1 1 -1 -1 1 -1 1; 1 1 -1 -1 -1 -1 1 1; 1 -1 -1 1 -1 1 1 -1]
