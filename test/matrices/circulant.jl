# constructors
@test allequal([
    Circulant(5),
    Circulant{Int}(5),
    Circulant([1:5;]),
])

# linear algebra functions
run_test_linearalgrbra_functions(Circulant.(1:5))

# eltype
@test test_matrix_elements(Circulant{Int32}(5))

# content
@test Circulant(5) ≈ [1 2 3 4 5; 5 1 2 3 4; 4 5 1 2 3; 3 4 5 1 2; 2 3 4 5 1]
