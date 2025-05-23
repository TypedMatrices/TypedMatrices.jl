# constructors
@test allequal([
    Redheff(5),
    Redheff{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Redheff.(1:5))
run_test_properties(Redheff, 3:5)

# eltype
@test test_matrix_elements(Redheff{Int32}(5))

# content
@test Redheff(5) ≈ [1 1 1 1 1; 1 1 0 1 0; 1 0 1 0 0; 1 0 0 1 0; 1 0 0 0 1]
