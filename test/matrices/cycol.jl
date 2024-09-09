# constructors & content (random matrix)
@test allequal([
    size(Cycol(5)),
    size(Cycol(5, 1)),
    size(Cycol(5, 5, 1)),
    size(Cycol{Float64}(5)),
    size(Cycol{Float64}(5, 1)),
    size(Cycol{Float64}(5, 5, 1)),
])

# linear algebra functions
run_test_linear_algebra_functions(Cycol.(1:5))

# eltype
@test test_matrix_elements(Cycol{Float32}(5))
