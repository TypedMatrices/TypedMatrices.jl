# constructors
@test allequal([
    Grcar(5),
    Grcar(5, 3),
    Grcar{Int}(5),
    Grcar{Int}(5, 3),
])

# linear algebra functions
run_test_linear_algebra_functions(Grcar.(1:5))
run_test_properties(Grcar, 3:5)

# eltype
@test test_matrix_elements(Grcar{Int32}(5))

# content
@test Grcar(5) ≈ [1 1 1 1 0; -1 1 1 1 1; 0 -1 1 1 1; 0 0 -1 1 1; 0 0 0 -1 1]
@test Grcar(5, 2) ≈ [1 1 1 0 0; -1 1 1 1 0; 0 -1 1 1 1; 0 0 -1 1 1; 0 0 0 -1 1]
