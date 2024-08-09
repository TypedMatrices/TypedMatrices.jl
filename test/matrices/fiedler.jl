# constructors
@test allequal([
    Fiedler(5),
    Fiedler{Int}(5),
    Fiedler([1:5;]),
])

# linear algebra functions
run_test_linearalgrbra_functions(Fiedler.(1:5))

# eltype
@test test_matrix_elements(Fiedler{Int32}(5))

# content
@test Fiedler(5) ≈ [0 1 2 3 4; 1 0 1 2 3; 2 1 0 1 2; 3 2 1 0 1; 4 3 2 1 0]
