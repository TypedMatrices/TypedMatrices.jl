# constructors
@test allequal([
    Riemann(5),
    Riemann{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Riemann.(1:5))

# eltype
@test test_matrix_elements(Riemann{Int32}(5))

# content
@test Riemann(5) ≈ [1 -1 1 -1 1; -1 2 -1 -1 2; -1 -1 3 -1 -1; -1 -1 -1 4 -1; -1 -1 -1 -1 5]
