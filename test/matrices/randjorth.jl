# constructors & content (random matrix)
@test allequal([
    size(Randjorth(5)),
    size(Randjorth{Float64}(5)),
])

# linear algebra functions
run_test_linear_algebra_functions(Randjorth.(1:5))
run_test_properties(Randjorth, 3:5)

# eltype
@test test_matrix_elements(Randjorth{Float32}(5))
