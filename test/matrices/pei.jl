# constructors
@test allequal([
    Pei(5),
    Pei(5, 1),
    Pei{Int}(5),
    Pei{Int}(5, 1),
])

# linear algebra functions
run_test_linear_algebra_functions(Pei.(1:5))
run_test_properties(Pei, 3:5)

# eltype
@test test_matrix_elements(Pei{Int32}(5))

# content
@test Pei(5) ≈ [2 1 1 1 1; 1 2 1 1 1; 1 1 2 1 1; 1 1 1 2 1; 1 1 1 1 2]
@test Pei(5, 3) ≈ [4 1 1 1 1; 1 4 1 1 1; 1 1 4 1 1; 1 1 1 4 1; 1 1 1 1 4]
