# constructors 
@test allequal([
    Strakos(5, 5e-1, 1, 1e3),
    Strakos(5, 0.5, 1, 1000),
    Strakos{Float64}(5, 0.5, 1, 1000),
])

# linear algebra functions
run_test_linear_algebra_functions(Strakos.(2:5))
run_test_properties(Strakos, 5)

# eltype
@test test_matrix_elements(Strakos{Float32}(5))

# content
@test Strakos(4, 0.5, 1, 7) ≈ [1 0 0 0; 0 1.5 0 0; 0 0 3 0; 0 0 0 7]