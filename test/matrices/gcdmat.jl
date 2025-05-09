# constructors
@test allequal([
    GCDMat(5),
    GCDMat{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(GCDMat.(1:5))
run_test_properties(GCDMat, 3:5)

# eltype
@test test_matrix_elements(GCDMat{Int32}(5))

# content
@test GCDMat(5) ≈ [1 1 1 1 1; 1 2 1 2 1; 1 1 3 1 1; 1 2 1 4 1; 1 1 1 1 5]
