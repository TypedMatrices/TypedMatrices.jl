# constructors
@test allequal([
    GearMat(5),
    GearMat(5, 5, -5),
    GearMat{Int}(5),
    GearMat{Int}(5, 5, -5),
])

# linear algebra functions
run_test_linear_algebra_functions(GearMat.(1:5))

# eltype
@test test_matrix_elements(GearMat{Int32}(5))

# content
@test GearMat(5) ≈ [0 1 0 0 1; 1 0 1 0 0; 0 1 0 1 0; 0 0 1 0 1; -1 0 0 1 0]
@test GearMat(5, 4, 4) ≈ [0 1 0 1 0; 1 0 1 0 0; 0 1 0 1 0; 0 0 1 0 1; 0 1 0 1 0]
@test GearMat(5, -3, -3) ≈ [0 1 -1 0 0; 1 0 1 0 0; 0 1 0 1 0; 0 0 1 0 1; 0 0 -1 1 0]
@test GearMat(5, -2, -2) ≈ [0 -1 0 0 0; 1 0 1 0 0; 0 1 0 1 0; 0 0 1 0 1; 0 0 0 -1 0]
