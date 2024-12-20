# constructors
@test allequal([
    Frank(5),
    Frank(5, 0),
    Frank{Int}(5),
    Frank{Int}(5, 0),
])

# linear algebra functions
run_test_linear_algebra_functions(Frank.(1:5))

# eltype
@test test_matrix_elements(Frank{Int32}(5))

# content
@test Frank(5) ≈ [5 4 3 2 1; 4 4 3 2 1; 0 3 3 2 1; 0 0 2 2 1; 0 0 0 1 1]
@test Frank(5, 1) ≈ [1 1 1 1 1; 1 2 2 2 2; 0 2 3 3 3; 0 0 3 4 4; 0 0 0 4 5]
