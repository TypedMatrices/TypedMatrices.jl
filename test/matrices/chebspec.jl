# constructors
@test allequal([
    ChebSpec(5),
    ChebSpec(5, 0),
    ChebSpec{Float64}(5),
    ChebSpec{Float64}(5, 0),
])

# linear algebra functions
run_test_linear_algebra_functions(ChebSpec.(1:5))
run_test_properties(ChebSpec, 3:5)

# eltype
@test test_matrix_elements(ChebSpec{Float32}(5))

# content
@test ChebSpec(5) ≈ [5.5 -6.828427124746192 2.0000000000000004 -1.17157287525381 0.5; 1.707106781186548 -0.7071067811865477 -1.4142135623730951 0.7071067811865476 -0.2928932188134525; -0.5000000000000001 1.4142135623730951 -3.061616997868383e-17 -1.414213562373095 0.5; 0.2928932188134525 -0.7071067811865476 1.414213562373095 0.7071067811865474 -1.7071067811865472; -0.5 1.17157287525381 -2.0 6.828427124746189 -5.5]
@test ChebSpec(5, 1) ≈ [-1.170820393249937 -2.0 0.8944271909999159 -0.6180339887498948 0.276393202250021; 2.0 -0.17082039324993692 -1.618033988749895 0.8944271909999159 -0.38196601125010515; -0.8944271909999159 1.618033988749895 0.17082039324993686 -2.0 0.7236067977499789; 0.6180339887498948 -0.8944271909999159 2.0 1.1708203932499364 -2.6180339887498936; -1.105572809000084 1.5278640450004206 -2.8944271909999157 10.472135954999574 -8.5]
