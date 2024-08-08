using Test
using TypedMatrices
using LinearAlgebra

const builtin_matrices = list_matrices(Group(:builtin))

function test_matrix_elements(A::AbstractMatrix{T}) where {T}
    return all(typeof(A[i]) == T for i = eachindex(A))
end

function test_linearalgrbra_functions(A::AbstractMatrix)
    matrix = Matrix(A)
    determinant = det(matrix)
    result = Dict([
        isdiag => isdiag(A) == isdiag(matrix),
        ishermitian => ishermitian(A) == ishermitian(matrix),
        issymmetric => issymmetric(A) == issymmetric(matrix),
        adjoint => adjoint(A) ≈ adjoint(matrix),
        transpose => transpose(A) ≈ transpose(matrix),
        det => det(A) == determinant,
    ])

    # https://github.com/JuliaLang/julia/issues/55404
    if VERSION >= v"1.10"
        result[isposdef] = isposdef(A) == isposdef(matrix)
        result[eigvals]  = eigvals(A) ≈ eigvals(matrix)

        if determinant != 0
            result[inv] = inv(A) ≈ inv(matrix)
        end
    end

    if all(values(result))
        return true
    else
        @error result
        return false
    end
end

function test_linearalgrbra_functions(matrices::Vector{<:AbstractMatrix})
    for matrix = matrices
        @test test_linearalgrbra_functions(matrix)
    end
end

if VERSION < v"1.8"
    allequal(itr) = isempty(itr) ? true : all(isequal(first(itr)), itr)
end

@testset "TypedMatrices.jl" begin
    @testset "core" begin
        include("types.jl")
        include("metadata.jl")
        include("matrices.jl")
    end

    @testset "matrices" begin
        @testset "$file" for file = readdir("matrices")
            include("matrices/$file")
        end
    end
end
