# constructors
@test allequal([
    Cauchy(5),
    Cauchy(5, 5),
    Cauchy([1:5;]),
    Cauchy([1:5;], [1:5;]),
    Cauchy{Int}(5),
    Cauchy{Int}(5, 5),
    Cauchy{Int}([1:5;]),
    Cauchy{Int}([1:5;], [1:5;]),
    Cauchy{Int}([1:5;], [1:5;]),
])

# linear algebra functions
run_test_linear_algebra_functions(Cauchy{Float64}.(1:5))

# eltype
@test test_matrix_elements(Cauchy{Float32}(5))

# content
@test Cauchy(5) ≈ [0.5 0.3333333333333333 0.25 0.2 0.16666666666666666; 0.3333333333333333 0.25 0.2 0.16666666666666666 0.14285714285714285; 0.25 0.2 0.16666666666666666 0.14285714285714285 0.125; 0.2 0.16666666666666666 0.14285714285714285 0.125 0.1111111111111111; 0.16666666666666666 0.14285714285714285 0.125 0.1111111111111111 0.1]
