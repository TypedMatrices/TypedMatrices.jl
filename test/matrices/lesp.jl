# constructors
@test allequal([
    Lesp(5),
    Lesp{Float64}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Lesp.(1:5))
run_test_properties(Lesp, 3:5)

# eltype
@test test_matrix_elements(Lesp{Float32}(5))

# content
@test Lesp(5) ≈ [-5.0 2.0 0.0 0.0 0.0; 0.5 -7.0 3.0 0.0 0.0; 0.0 0.3333333333333333 -9.0 4.0 0.0; 0.0 0.0 0.25 -11.0 5.0; 0.0 0.0 0.0 0.2 -13.0]
