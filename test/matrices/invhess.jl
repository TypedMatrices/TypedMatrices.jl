# constructors
@test allequal([
    Invhess(5),
    Invhess{Int}(5),
    Invhess([1:5;]),
    Invhess([1:5;], -[1:4;]),
])

# linear algebra functions
run_test_linearalgrbra_functions(Invhess.(1:5))

# eltype
@test test_matrix_elements(Invhess{Int32}(5))

# content
@test Invhess(5) ≈ [1 -1 -1 -1 -1; 1 2 -2 -2 -2; 1 2 3 -3 -3; 1 2 3 4 -4; 1 2 3 4 5]
@test Invhess([-8:1:-4;], [2:5;]) ≈ [-8 2 2 2 2; -8 -7 3 3 3; -8 -7 -6 4 4; -8 -7 -6 -5 5; -8 -7 -6 -5 -4]
