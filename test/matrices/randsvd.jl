# constructors & content (random matrix)
@test allequal([
    size(RandSVD(5)),
    size(RandSVD(5, sqrt(1 / eps()))),
    size(RandSVD(5, sqrt(1 / eps()), 3)),
    size(RandSVD(5, 5, sqrt(1 / eps()), 3)),
    size(RandSVD{Float64}(5)),
    size(RandSVD{Float64}(5, sqrt(1 / eps()))),
    size(RandSVD{Float64}(5, sqrt(1 / eps()), 3)),
    size(RandSVD{Float64}(5, 5, sqrt(1 / eps()), 3)),

    # modes
    size(RandSVD(5, sqrt(1 / eps()), 1)),
    size(RandSVD(5, sqrt(1 / eps()), 2)),
    size(RandSVD(5, sqrt(1 / eps()), 4)),
    size(RandSVD(5, sqrt(1 / eps()), 5)),
])

# linear algebra functions
run_test_linear_algebra_functions(RandSVD.(1:5))

# eltype
@test test_matrix_elements(RandSVD{Float32}(5))
