# constructors
@test allequal([
    Parter(5),
    Parter{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Parter.(1:5))

# eltype
@test test_matrix_elements(Parter{Int32}(5))

# content
@test Parter(5) ≈ [2.0 -2.0 -0.6666666666666666 -0.4 -0.2857142857142857; 0.6666666666666666 2.0 -2.0 -0.6666666666666666 -0.4; 0.4 0.6666666666666666 2.0 -2.0 -0.6666666666666666; 0.2857142857142857 0.4 0.6666666666666666 2.0 -2.0; 0.2222222222222222 0.2857142857142857 0.4 0.6666666666666666 2.0]
