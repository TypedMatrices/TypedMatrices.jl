# constructors
@test allequal([
    Lauchli(5),
    Lauchli(5, sqrt(eps())),
    Lauchli{Float64}(5),
    Lauchli{Float64}(5, sqrt(eps())),
])

# eltype
@test test_matrix_elements(Lauchli{Float32}(5))
@test test_matrix_elements(Lauchli{Float64}(5))

# content
@test Lauchli(5) ≈ [1.0 1.0 1.0 1.0 1.0; 1.4901161193847656e-8 0.0 0.0 0.0 0.0; 0.0 1.4901161193847656e-8 0.0 0.0 0.0; 0.0 0.0 1.4901161193847656e-8 0.0 0.0; 0.0 0.0 0.0 1.4901161193847656e-8 0.0; 0.0 0.0 0.0 0.0 1.4901161193847656e-8]
@test Lauchli(5, 2) ≈ [1 1 1 1 1; 2 0 0 0 0; 0 2 0 0 0; 0 0 2 0 0; 0 0 0 2 0; 0 0 0 0 2]
@test Lauchli(5, 4.3) ≈ [1.0 1.0 1.0 1.0 1.0; 4.3 0.0 0.0 0.0 0.0; 0.0 4.3 0.0 0.0 0.0; 0.0 0.0 4.3 0.0 0.0; 0.0 0.0 0.0 4.3 0.0; 0.0 0.0 0.0 0.0 4.3]
