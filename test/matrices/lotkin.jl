# constructors
@test allequal([
    Lotkin(5),
    Lotkin{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Lotkin.(1:5))

# eltype
@test test_matrix_elements(Lotkin{Int32}(5))

# content
@test Lotkin(5) ≈ [1.0 1.0 1.0 1.0 1.0; 0.5 0.3333333333333333 0.25 0.2 0.16666666666666666; 0.3333333333333333 0.25 0.2 0.16666666666666666 0.14285714285714285; 0.25 0.2 0.16666666666666666 0.14285714285714285 0.125; 0.2 0.16666666666666666 0.14285714285714285 0.125 0.1111111111111111]
