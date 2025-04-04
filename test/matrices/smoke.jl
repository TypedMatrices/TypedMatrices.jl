# constructors
@test allequal([
    Smoke(5),
    Smoke(5, 0),
    Smoke{Float64}(5),
    Smoke{Float64}(5, 0),
    Smoke{Complex{Float64}}(5),
    Smoke{Complex{Float64}}(5, 0),
])

# linear algebra functions
run_test_linear_algebra_functions(Smoke.(1:5))
run_test_properties(Smoke, 3:5)

# eltype
@test test_matrix_elements(Smoke{Float32}(5))

# content
@test Smoke(5) ≈ Smoke(5, 0) ≈ [0.30901699437494734+0.9510565162951536im 1.0+0.0im 0.0+0.0im 0.0+0.0im 0.0+0.0im; 0.0+0.0im -0.8090169943749476+0.587785252292473im 1.0+0.0im 0.0+0.0im 0.0+0.0im; 0.0+0.0im 0.0+0.0im -0.8090169943749476-0.587785252292473im 1.0+0.0im 0.0+0.0im; 0.0+0.0im 0.0+0.0im 0.0+0.0im 0.3090169943749477-0.9510565162951535im 1.0+0.0im; 1.0+0.0im 0.0+0.0im 0.0+0.0im 0.0+0.0im 1.0+0.0im]
@test Smoke(5, 1) ≈ [0.30901699437494734+0.9510565162951536im 1.0+0.0im 0.0+0.0im 0.0+0.0im 0.0+0.0im; 0.0+0.0im -0.8090169943749476+0.587785252292473im 1.0+0.0im 0.0+0.0im 0.0+0.0im; 0.0+0.0im 0.0+0.0im -0.8090169943749476-0.587785252292473im 1.0+0.0im 0.0+0.0im; 0.0+0.0im 0.0+0.0im 0.0+0.0im 0.3090169943749477-0.9510565162951535im 1.0+0.0im; 0.0+0.0im 0.0+0.0im 0.0+0.0im 0.0+0.0im 1.0+0.0im]
