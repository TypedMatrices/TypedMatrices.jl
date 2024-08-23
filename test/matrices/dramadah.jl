# constructors
@test allequal([
    Dramadah(5),
    Dramadah(5, 1),
    Dramadah{Int}(5),
    Dramadah{Int}(5, 1),
])

# linear algebra functions
run_test_linearalgrbra_functions(Dramadah.(1:5))

# eltype
@test test_matrix_elements(Dramadah{Int32}(5))

# content
@test Dramadah(5) ≈ [1 1 0 1 0; 0 1 1 0 1; 0 0 1 1 0; 1 0 0 1 1; 1 1 0 0 1]
@test Dramadah(5, 1) ≈ [1 1 0 1 0; 0 1 1 0 1; 0 0 1 1 0; 1 0 0 1 1; 1 1 0 0 1]
@test Dramadah(5, 2) ≈ [1 1 0 1 0; 0 1 1 0 1; 0 0 1 1 0; 0 0 0 1 1; 0 0 0 0 1]
@test Dramadah(5, 3) ≈ [1 1 0 0 0; 0 1 1 0 0; 1 0 1 1 0; 0 1 0 1 1; 1 0 1 0 1]
