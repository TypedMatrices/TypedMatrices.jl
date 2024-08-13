# constructors & content (random matrix)
@test allequal([
    size(Rosser(4)),
    size(Rosser(4, 1, 1)),
    size(Rosser{Float64}(4)),
    size(Rosser{Float64}(4, 1, 1)),
])
@test !isnothing(Rosser(0))

# linear algebra functions
run_test_linearalgrbra_functions(Rosser.((2) .^ (1:4)))

# eltype
@test test_matrix_elements(Rosser{Float32}(4))
