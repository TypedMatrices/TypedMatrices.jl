# constructors
@test allequal([
    Prolate(5),
    Prolate(5, 0.25),
    Prolate{Float64}(5),
    Prolate{Float64}(5, 0.25),
])

# linear algebra functions
run_test_linear_algebra_functions(Prolate.(1:5))

# eltype
@test test_matrix_elements(Prolate{Float32}(5))

# content
@test Prolate(5) ≈ [0.5 7.796343665038751e-17 -0.954929658551372 -3.1185374660155004e-16 1.5915494309189535; 7.796343665038751e-17 0.5 7.796343665038751e-17 -0.954929658551372 -3.1185374660155004e-16; -0.954929658551372 7.796343665038751e-17 0.5 7.796343665038751e-17 -0.954929658551372; -3.1185374660155004e-16 -0.954929658551372 7.796343665038751e-17 0.5 7.796343665038751e-17; 1.5915494309189535 -3.1185374660155004e-16 -0.954929658551372 7.796343665038751e-17 0.5]
@test Prolate(5, 0.84) ≈ [1.68 -0.5760307921729466 -0.11968442193269915 0.9810479304442622 1.5136534572813118; -0.5760307921729466 1.68 -0.5760307921729466 -0.11968442193269915 0.9810479304442622; -0.11968442193269915 -0.5760307921729466 1.68 -0.5760307921729466 -0.11968442193269915; 0.9810479304442622 -0.11968442193269915 -0.5760307921729466 1.68 -0.5760307921729466; 1.5136534572813118 0.9810479304442622 -0.11968442193269915 -0.5760307921729466 1.68]
