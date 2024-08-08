# constructors
@test allequal([
    DingDong(5),
    DingDong{Int}(5),
])

# linear algebra functions
test_linearalgrbra_functions(DingDong.(1:5))

# eltype
@test test_matrix_elements(DingDong{Int32}(5))

# content
@test DingDong(5) ≈ [0.1111111111111111 0.14285714285714285 0.2 0.3333333333333333 1.0; 0.14285714285714285 0.2 0.3333333333333333 1.0 -1.0; 0.2 0.3333333333333333 1.0 -1.0 -0.3333333333333333; 0.3333333333333333 1.0 -1.0 -0.3333333333333333 -0.2; 1.0 -1.0 -0.3333333333333333 -0.2 -0.14285714285714285]
