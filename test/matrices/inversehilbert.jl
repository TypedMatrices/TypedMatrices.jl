# constructors
@test allequal([
    InverseHilbert(5),
    InverseHilbert{Int}(5),
    InverseHilbert{Rational{Int}}(5),
])

# linear algebra functions
run_test_linear_algebra_functions(InverseHilbert.(1:5))
run_test_linear_algebra_functions([InverseHilbert{BigInt}(5)])

# eltype
@test test_matrix_elements(InverseHilbert{Int32}(5))

# content
@test InverseHilbert(5) ≈ [25 -300 1050 -1400 630; -300 4800 -18900 26880 -12600; 1050 -18900 79380 -117600 56700; -1400 26880 -117600 179200 -88200; 630 -12600 56700 -88200 44100]
