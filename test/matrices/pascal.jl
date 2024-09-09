# constructors
@test allequal([
    Pascal(5),
    Pascal{Int}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(Pascal.(1:5))

# eltype
@test test_matrix_elements(Pascal{Int32}(5))

# content
@test Pascal(5) ≈ [1 1 1 1 1; 1 2 3 4 5; 1 3 6 10 15; 1 4 10 20 35; 1 5 15 35 70]
