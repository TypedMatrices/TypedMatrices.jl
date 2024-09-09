# constructors & content (random matrix)
@test allequal([
    size(Rohess(5)),
    size(Rohess{Float64}(5)),
])

# linear algebra functions
run_test_linear_algebra_functions(Rohess.(1:5))

# eltype
@test test_matrix_elements(Rohess{Float32}(5))
