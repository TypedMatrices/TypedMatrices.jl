# constructors
@test allequal([
    Moler(5),
    Moler(5, -1),
    Moler{Float64}(5),
    Moler{Float64}(5, -1),
])

# linear algebra functions
run_test_linearalgrbra_functions(Moler.(1:5))

# eltype
@test test_matrix_elements(Moler{Float32}(5))

# content
@test Moler(5) ≈ [1.0 -1.0 -1.0 -1.0 -1.0; -1.0 2.0 0.0 0.0 0.0; -1.0 0.0 3.0 1.0 1.0; -1.0 0.0 1.0 4.0 2.0; -1.0 0.0 1.0 2.0 5.0]
@test Moler(5, 2.5) ≈ [1.0 2.5 2.5 2.5 2.5; 2.5 7.25 8.75 8.75 8.75; 2.5 8.75 13.5 15.0 15.0; 2.5 8.75 15.0 19.75 21.25; 2.5 8.75 15.0 21.25 26.0]
