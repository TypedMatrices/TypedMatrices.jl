# constructors
@test allequal([
    RIS(5),
    RIS{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(RIS.(1:5))
run_test_properties(RIS, 3:5)

# eltype
@test test_matrix_elements(RIS{Int32}(5))

# content
@test RIS(5) ≈ [0.1111111111111111 0.14285714285714285 0.2 0.3333333333333333 1.0; 0.14285714285714285 0.2 0.3333333333333333 1.0 -1.0; 0.2 0.3333333333333333 1.0 -1.0 -0.3333333333333333; 0.3333333333333333 1.0 -1.0 -0.3333333333333333 -0.2; 1.0 -1.0 -0.3333333333333333 -0.2 -0.14285714285714285]
