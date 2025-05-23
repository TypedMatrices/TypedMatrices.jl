# constructors & content (random matrix)
@test allequal([
    size(Rando(5)),
    size(Rando(5, 1)),
    size(Rando(5, 5, 1)),
    size(Rando{Float64}(5)),
    size(Rando{Float64}(5, 1)),
    size(Rando{Float64}(5, 5, 1)),

    # modes
    size(Rando(5, 2)),
    size(Rando(5, 3)),
])

# linear algebra functions
run_test_linear_algebra_functions(Rando.(1:5))
run_test_properties(Rando, 3:5)

# eltype
@test test_matrix_elements(Rando{Float32}(5))
