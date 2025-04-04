# constructors & content (random matrix)
@test allequal([
    size(Randcorr(5)),
    size(Randcorr{Float64}(5)),
])

# linear algebra functions
run_test_linear_algebra_functions(Randcorr.(1:5))
run_test_properties(Randcorr, 3:5)

# eltype
@test test_matrix_elements(Randcorr{Float32}(5))
