# constructors & content (random matrix)
@test allequal([
    size(Wathen(5)),
    size(Wathen(5, 5)),
    size(Wathen{Float64}(5, 5)),
])

# linear algebra functions
run_test_linearalgrbra_functions(Wathen.(1:5))

# eltype
@test test_matrix_elements(Wathen{Float32}(5))