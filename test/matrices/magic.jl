# constructors
@test allequal([
    Magic(5),
    Magic{Int}(5),
])

# linear algebra functions
run_test_linearalgrbra_functions(Magic.(3:5))

# eltype
@test test_matrix_elements(Magic{Int32}(5))

# content
@test Magic(4) ≈ [16 5 9 4; 2 11 7 14; 3 10 6 15; 13 8 12 1]
@test Magic(5) ≈ [17 24 1 8 15; 23 5 7 14 16; 4 6 13 20 22; 10 12 19 21 3; 11 18 25 2 9]
@test Magic(6) ≈ [35 1 6 26 19 24; 3 32 7 21 23 25; 31 9 2 22 27 20; 8 28 33 17 10 15; 30 5 34 12 14 16; 4 36 29 13 18 11]
