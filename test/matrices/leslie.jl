# constructors
@test allequal([
    Leslie(5),
    Leslie(ones(5), ones(4)),
    Leslie{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Leslie.(1:5))

# eltype
@test test_matrix_elements(Leslie{Int32}(5))

# content
@test Leslie(5) ≈ [1 1 1 1 1; 1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0]
@test Leslie([2:6;], [5:8;]) ≈ [2 3 4 5 6; 5 0 0 0 0; 0 6 0 0 0; 0 0 7 0 0; 0 0 0 8 0]
