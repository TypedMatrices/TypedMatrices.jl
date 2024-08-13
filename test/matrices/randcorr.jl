# constructors & content (random matrix)
@test allequal([
    size(Randcorr(5)),
    size(Randcorr{Float64}(5)),
])

# linear algebra functions
run_test_linearalgrbra_functions(Randcorr.(1:5))

# eltype
@test test_matrix_elements(Randcorr{Float32}(5))
