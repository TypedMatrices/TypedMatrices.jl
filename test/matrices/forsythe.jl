# constructors
@test allequal([
    Forsythe(5),
    Forsythe{Float64}(5),
    Forsythe(5, sqrt(eps(Float64)), zero(Float64)),
    Forsythe{Float64}(5, sqrt(eps(Float64)), zero(Float64)),
])

# linear algebra functions
run_test_linear_algebra_functions(Forsythe.(1:5))

# eltype
@test test_matrix_elements(Forsythe{Float32}(5))

# content
@test Forsythe(5) ≈ [0.0 1.0 0.0 0.0 0.0; 0.0 0.0 1.0 0.0 0.0; 0.0 0.0 0.0 1.0 0.0; 0.0 0.0 0.0 0.0 1.0; 1.4901161193847656e-8 0.0 0.0 0.0 0.0]
@test Forsythe(5, 2, 3) ≈ [3.0 1.0 0.0 0.0 0.0; 0.0 3.0 1.0 0.0 0.0; 0.0 0.0 3.0 1.0 0.0; 0.0 0.0 0.0 3.0 1.0; 2.0 0.0 0.0 0.0 3.0]
@test Forsythe(5, 3, -5) ≈ [-5.0 1.0 0.0 0.0 0.0; 0.0 -5.0 1.0 0.0 0.0; 0.0 0.0 -5.0 1.0 0.0; 0.0 0.0 0.0 -5.0 1.0; 3.0 0.0 0.0 0.0 -5.0]
