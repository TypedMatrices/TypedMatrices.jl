# constructors
@test allequal([
    Triw(5),
    Triw(5, 5),
    Triw(5, -1),
    Triw(5, -1, 4),
    Triw{Int}(5),
    Triw{Int}(5, 5),
    Triw{Int}(5, 5, -1),
    Triw{Int}(5, 5, -1, 4),
])

# linear algebra functions
run_test_linear_algebra_functions(Triw.(1:5))

# eltype
@test test_matrix_elements(Triw{Int32}(5))

# content
@test Triw(5) ≈ [1 -1 -1 -1 -1; 0 1 -1 -1 -1; 0 0 1 -1 -1; 0 0 0 1 -1; 0 0 0 0 1]
@test Triw(5, 3, 4) ≈ [1 3 3 3 3; 0 1 3 3 3; 0 0 1 3 3; 0 0 0 1 3; 0 0 0 0 1]
@test Triw(5, 3.2, 2) ≈ [1.0 3.2 3.2 0.0 0.0; 0.0 1.0 3.2 3.2 0.0; 0.0 0.0 1.0 3.2 3.2; 0.0 0.0 0.0 1.0 3.2; 0.0 0.0 0.0 0.0 1.0]
