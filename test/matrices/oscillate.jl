# constructors & content (random matrix)
@test allequal([
    size(Oscillate(5)),
    size(Oscillate(5, 2)),
    size(Oscillate([1.0, 0.1, 0.1, 0.1, 0.1])),
    size(Oscillate{Float64}(5)),
    size(Oscillate{Float64}(5, 2)),
    size(Oscillate{Float64}([1.0, 0.1, 0.1, 0.1, 0.1])),

    # modes
    size(Oscillate(5, 1)),
])

# linear algebra functions
run_test_linear_algebra_functions(Oscillate.(2:5))
run_test_properties(Oscillate, 3:5)

# eltype
@test test_matrix_elements(Oscillate{Float32}(5))
