# constructors
@test allequal([
    Involutory(5),
    Involutory{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Involutory.(1:5))
run_test_properties(Involutory, 3:5)

# eltype
@test test_matrix_elements(Involutory{Int32}(5))

# content
@test Involutory(5) ≈ [-5.0 0.5 0.3333333333333333 0.25 0.2; -300.0 40.0 30.0 24.0 20.0; 1050.0 -157.5 -126.0 -105.0 -90.0; -1400.0 224.0 186.66666666666666 160.0 140.0; 630.0 -105.0 -90.0 -78.75 -70.0]
