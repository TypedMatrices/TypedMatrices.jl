# constructors
@test allequal([
    Lehmer(5),
    Lehmer{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Lehmer{Float64}.(1:5))

# eltype
@test test_matrix_elements(Lehmer{Int32}(5))

# content
@test Lehmer(5) ≈ [1.0 0.5 0.3333333333333333 0.25 0.2; 0.5 1.0 0.6666666666666666 0.5 0.4; 0.3333333333333333 0.6666666666666666 1.0 0.75 0.6; 0.25 0.5 0.75 1.0 0.8; 0.2 0.4 0.6 0.8 1.0]
