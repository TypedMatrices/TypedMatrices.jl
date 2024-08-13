# constructors & content (random matrix)
@test allequal([
    size(Rosser(4)),
    size(Rosser(4, 1, 1)),
    size(Rosser{Float64}(4)),
    size(Rosser{Float64}(4, 1, 1)),
])
@test !isnothing(Rosser(0))
@test !isnothing(Rosser(1))
@test !isnothing(Rosser(8))
@test !isnothing(Rosser(16))

# linear algebra functions
run_test_linearalgrbra_functions(Rosser.((2) .^ (1:2)))

# eltype
@test test_matrix_elements(Rosser{Float32}(4))
