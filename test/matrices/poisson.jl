# constructors
@test allequal([
    Poisson(4),
    Poisson{Int}(4),
])

# linear algebra functions
run_test_linear_algebra_functions(Poisson.((1:3) .^ 2))

# eltype
@test test_matrix_elements(Poisson{Int32}(4))

# content
@test Poisson(4) ≈ [4.0 -1.0 -1.0 0.0; -1.0 4.0 0.0 -1.0; -1.0 0.0 4.0 -1.0; 0.0 -1.0 -1.0 4.0]
