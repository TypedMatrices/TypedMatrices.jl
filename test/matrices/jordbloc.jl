# constructors
@test allequal([
    JordBloc(5),
    JordBloc(5, 1),
    JordBloc{Int}(5),
    JordBloc{Int}(5, 1),
])

# linear algebra functions
run_test_linear_algebra_functions(JordBloc.(1:5))

# eltype
@test test_matrix_elements(JordBloc{Int32}(5))

# content
@test JordBloc(5) ≈ JordBloc(5, 1) ≈ [1 1 0 0 0; 0 1 1 0 0; 0 0 1 1 0; 0 0 0 1 1; 0 0 0 0 1]
@test JordBloc(5, 3) ≈ [3 1 0 0 0; 0 3 1 0 0; 0 0 3 1 0; 0 0 0 3 1; 0 0 0 0 3]
