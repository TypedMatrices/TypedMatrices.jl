# constructors & content (random matrix)
@test allequal([
    size(Golub(5)),
    size(Golub{Int}(5)),
    size(Golub{Float64}(5)),
])

# linear algebra functions
test_linearalgrbra_functions(Golub.(1:5))

# eltype
@test test_matrix_elements(Golub{Int32}(5))
