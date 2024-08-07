# content
@test Cauchy(5) ≈ [0.5 0.3333333333333333 0.25 0.2 0.16666666666666666; 0.3333333333333333 0.25 0.2 0.16666666666666666 0.14285714285714285; 0.25 0.2 0.16666666666666666 0.14285714285714285 0.125; 0.2 0.16666666666666666 0.14285714285714285 0.125 0.1111111111111111; 0.16666666666666666 0.14285714285714285 0.125 0.1111111111111111 0.1]

# eltype
@test test_matrix_elements(Cauchy{Float32}(5))

# constructors
@test allequal([
    Cauchy(5),
    Cauchy(5, 5),
    Cauchy([1:5;]),
    Cauchy([1:5;], [1:5;]),
    Cauchy{Int}(5),
    Cauchy{Int}(5,5),
    Cauchy{Int}([1:5;]),
    Cauchy{Int}([1:5;], [1:5;]),
    Cauchy{Int}([1:5;], [1:5;]),
])

# linear algebra functions
@test test_linearalgrbra_functions(Cauchy{Float64}(5))
