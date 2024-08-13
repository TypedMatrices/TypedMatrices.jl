# constructors
@test allequal([
    Wilkinson(5),
    Wilkinson{Float64}(5),
])

# linear algebra functions
run_test_linearalgrbra_functions(Wilkinson.(1:5))

# eltype
@test test_matrix_elements(Wilkinson{Float32}(5))

# content
@test Wilkinson(5) ≈ [2.0 1.0 0.0 0.0 0.0; 1.0 1.0 1.0 0.0 0.0; 0.0 1.0 0.0 1.0 0.0; 0.0 0.0 1.0 1.0 1.0; 0.0 0.0 0.0 1.0 2.0]
@test Wilkinson(4) ≈ [1.5 1.0 0.0 0.0; 1.0 0.5 1.0 0.0; 0.0 1.0 0.5 1.0; 0.0 0.0 1.0 1.5]

# Base.replace_in_print_matrix
@test Base.replace_in_print_matrix(Wilkinson(5), 1, 1, "a") == "a"
@test Base.replace_in_print_matrix(Wilkinson(5), 1, 5, "a") != "a"
