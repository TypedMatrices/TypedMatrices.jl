# constructors
@test allequal([
    Hanowa(6),
    Hanowa(6, -1),
    Hanowa{Int}(6),
    Hanowa{Int}(6, -1),
])

# linear algebra functions
run_test_linear_algebra_functions(Hanowa.(2:2:8))
run_test_properties(Hanowa, 3:5)

# eltype
@test test_matrix_elements(Hanowa{Int32}(6))

# content
@test Hanowa(6) ≈ [-1 0 0 -1 0 0; 0 -1 0 0 -2 0; 0 0 -1 0 0 -3; 1 0 0 -1 0 0; 0 2 0 0 -1 0; 0 0 3 0 0 -1]
@test Hanowa(6, 2) ≈ [2 0 0 -1 0 0; 0 2 0 0 -2 0; 0 0 2 0 0 -3; 1 0 0 2 0 0; 0 2 0 0 2 0; 0 0 3 0 0 2]
