# constructors
@test allequal([
    KMS(5),
    KMS(5, 0.5),
    KMS{Float64}(5),
    KMS{Float64}(5, Float32(0.5)),
    KMS{Float64}(5, 0.5),
])

# linear algebra functions
run_test_linear_algebra_functions(KMS.(1:5))
run_test_linear_algebra_functions(KMS.(1:5, 3))
run_test_linear_algebra_functions(KMS.(1:5, 3 + 2im))

# eltype
@test test_matrix_elements(KMS{Float32}(5))

# content
@test KMS(5) ≈ [1.0 0.5 0.25 0.125 0.0625; 0.5 1.0 0.5 0.25 0.125; 0.25 0.5 1.0 0.5 0.25; 0.125 0.25 0.5 1.0 0.5; 0.0625 0.125 0.25 0.5 1.0]
@test KMS(5, 3) ≈ [1 3 9 27 81; 3 1 3 9 27; 9 3 1 3 9; 27 9 3 1 3; 81 27 9 3 1]
