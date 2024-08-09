# constructors
@test allequal([
    Hankel(5),
    Hankel{Int}(5),
    Hankel([1:5;]),
    Hankel([1:5;], Int[]),
])

# linear algebra functions
run_test_linearalgrbra_functions(Hankel.(1:5))

# eltype
@test test_matrix_elements(Hankel{Int32}(5))

# content
@test Hankel(5) ≈ [1 2 3 4 5; 2 3 4 5 0; 3 4 5 0 0; 4 5 0 0 0; 5 0 0 0 0]
@test Hankel([2, 4, 6], [6, 5, 4, 3, 2, 1]) ≈ [2 4 6 5 4 3; 4 6 5 4 3 2; 6 5 4 3 2 1]
