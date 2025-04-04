# constructors
@test allequal([
    Krylov(Minij(5)),
    Krylov(Minij(5), ones(Int, 5), 5),
])

# constructors & content (random matrix)
@test allequal([
    size(Krylov(5)),
    size(Krylov(5, Float64[1:5;])),
    size(Krylov(5, Float64[1:5;], 5)),
    size(Krylov(Minij(5))),
    size(Krylov{Float64}(5)),
    size(Krylov{Float64}(5, Float64[1:5;])),
    size(Krylov{Float64}(5, Float64[1:5;], 5)),
    size(Krylov(Minij{Float64}(5), Float64[1:5;], 5)),
])

# linear algebra functions
run_test_linear_algebra_functions(Krylov.(1:5))
run_test_properties(Krylov, 3:5)

# eltype
@test test_matrix_elements(Krylov{Float32}(5))

# content
A = Minij(5)
@test Krylov(A) ≈ [1 5 55 671 8272; 1 9 105 1287 15873; 1 12 146 1798 22187; 1 14 175 2163 26703; 1 15 190 2353 29056]
@test Krylov(2 * A) ≈ [1 10 220 5368 132352; 1 18 420 10296 253968; 1 24 584 14384 354992; 1 28 700 17304 427248; 1 30 760 18824 464896]
@test Krylov(A, [1:5;], 5) ≈ [1 15 190 2353 29056; 2 29 365 4516 55759; 3 41 511 6314 77946; 4 50 616 7601 93819; 5 55 671 8272 102091]
@test Krylov(A, [-5:-1;], 5) ≈ [-5 -15 -140 -1673 -20576; -4 -25 -265 -3206 -39479; -3 -31 -365 -4474 -55176; -2 -34 -434 -5377 -66399; -1 -35 -469 -5846 -72245]
