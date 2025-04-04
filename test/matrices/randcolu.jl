# vector
x = rand(Float64, 5)
x = sqrt(5.0) * x / norm(x)

# constructors & content (random matrix)
@test allequal([
    size(Randcolu(5)),
    size(Randcolu(5, 5)),
    size(Randcolu(5, 5, 0)),
    size(Randcolu(x)),
    size(Randcolu(x, 5)),
    size(Randcolu(x, 5, 0)),
    size(Randcolu{Float64}(5)),
    size(Randcolu{Float64}(5, 5)),
    size(Randcolu{Float64}(5, 5, 0)),
])

@test_throws ArgumentError Randcolu([:rectangular, :illcond], 5)

# linear algebra functions
run_test_linear_algebra_functions(Randcolu.(1:5))
run_test_properties(Randcolu, 3:5)

# eltype
@test test_matrix_elements(Randcolu{Float32}(5))
