using Polynomials: Polynomial

# constructors
@test allequal([
    Companion(5),
    Companion(Polynomial([-5:-1; 1])),
    Companion{Int}(5),
    Companion{Float64}(Polynomial([-5:-1; 1])),
    Companion([1:5;]),
])

# linear algebra functions
run_test_linearalgrbra_functions(Companion.(1:5))

# eltype
@test test_matrix_elements(Companion{Float32}(5))

# content
@test Companion(5) ≈ [1 2 3 4 5; 1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0]
@test Companion(Polynomial(1:5)) ≈ [-0.8 -0.6 -0.4 -0.2; 1.0 0.0 0.0 0.0; 0.0 1.0 0.0 0.0; 0.0 0.0 1.0 0.0]
