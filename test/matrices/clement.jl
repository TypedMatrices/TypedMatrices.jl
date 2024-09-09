# constructors
@test allequal([
    Clement(5),
    Clement(5, 0),
    Clement{Float64}(5),
    Clement{Float64}(5, 0),
])

# linear algebra functions
run_test_linear_algebra_functions(Clement.(1:5))

# eltype
@test test_matrix_elements(Clement{Float32}(5))

# content
@test Clement(1) ≈ [0]
@test Clement(5) ≈ [0 1 0 0 0; 4 0 2 0 0; 0 3 0 3 0; 0 0 2 0 4; 0 0 0 1 0]
@test Clement(5, 1) ≈ [0.0 2.0 0.0 0.0 0.0; 2.0 0.0 2.449489742783178 0.0 0.0; 0.0 2.449489742783178 0.0 2.449489742783178 0.0; 0.0 0.0 2.449489742783178 0.0 2.0; 0.0 0.0 0.0 2.0 0.0]
