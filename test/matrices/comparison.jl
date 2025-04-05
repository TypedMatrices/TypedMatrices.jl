# constructors
@test allequal([
    Comparison(Minij(5)),
    Comparison(Minij(5), 0),
])

# linear algebra functions
run_test_linear_algebra_functions(Comparison.(Minij.(1:5)))
run_test_properties(Comparison, 3:5)

# eltype
@test test_matrix_elements(Comparison(Minij{Int32}(5)))

# content
@test Comparison(Minij(5)) ≈ Comparison(-Minij(5)) ≈ [1 -1 -1 -1 -1; -1 2 -2 -2 -2; -1 -2 3 -3 -3; -1 -2 -3 4 -4; -1 -2 -3 -4 5]
@test Comparison(Minij(5), 1) ≈ Comparison(-Minij(5), 1) ≈ [1 -1 -1 -1 -1; -2 2 -2 -2 -2; -3 -3 3 -3 -3; -4 -4 -4 4 -4; -4 -4 -4 -4 5]
@test Comparison(Hilbert(5)) ≈ Comparison(-Hilbert(5)) ≈ [1.0 -0.5 -0.3333333333333333 -0.25 -0.2; -0.5 0.3333333333333333 -0.25 -0.2 -0.16666666666666666; -0.3333333333333333 -0.25 0.2 -0.16666666666666666 -0.14285714285714285; -0.25 -0.2 -0.16666666666666666 0.14285714285714285 -0.125; -0.2 -0.16666666666666666 -0.14285714285714285 -0.125 0.1111111111111111]
@test Comparison(Hilbert(5), 1) ≈ Comparison(-Hilbert(5), 1) ≈ [1.0 -0.5 -0.5 -0.5 -0.5; -0.5 0.3333333333333333 -0.5 -0.5 -0.5; -0.3333333333333333 -0.3333333333333333 0.2 -0.3333333333333333 -0.3333333333333333; -0.25 -0.25 -0.25 0.14285714285714285 -0.25; -0.2 -0.2 -0.2 -0.2 0.1111111111111111]
