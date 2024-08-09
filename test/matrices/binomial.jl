# constructors
@test allequal([
    Binomial(5),
    Binomial{Int}(5),
])

# linear algebra functions
run_test_linearalgrbra_functions(Binomial.(1:5))

# eltype
@test test_matrix_elements(Binomial{Int32}(5))

# content
@test Binomial(5) ≈ [1 4 6 4 1; 1 2 0 -2 -1; 1 0 -2 0 1; 1 -2 0 2 -1; 1 -4 6 -4 1]
