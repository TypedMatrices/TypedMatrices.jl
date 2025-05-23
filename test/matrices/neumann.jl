# constructors
@test allequal([
    Neumann(4),
    Neumann{Int}(4),
])

# linear algebra functions
run_test_linear_algebra_functions(Neumann.((0:1) .^ 2))
run_test_properties(Neumann, [25, 36, 49, 64])

# eltype
@test test_matrix_elements(Neumann{Int32}(4))

# content
@test Neumann(1) ≈ [4]
@test Neumann(4) ≈ [4 -2 -2 0; -2 4 0 -2; -2 0 4 -2; 0 -2 -2 4]
