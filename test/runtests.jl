using Test
using TypedMatrices
using LinearAlgebra

const builtin_matrices = list_matrices(Group(:builtin))

function test_matrix_elements(A::AbstractMatrix{T}) where {T}
    return all(typeof(A[i]) == T for i = eachindex(A))
end

function test_linearalgrbra_functions(A::AbstractMatrix)
    matrix = Matrix(A)
    result = [
        isdiag(A) == isdiag(matrix),
        ishermitian(A) == ishermitian(matrix),
        isposdef(A) == isposdef(matrix),
        issymmetric(A) == issymmetric(matrix),
        adjoint(A) ≈ adjoint(matrix),
        transpose(A) ≈ transpose(matrix),
        det(A) == det(matrix),
        inv(A) ≈ inv(matrix),
        eigvals(A) ≈ eigvals(matrix),
    ]
    if all(result)
        return true
    else
        @error result
        return false
    end
end

@testset "TypedMatrices.jl" begin
    include("types.jl")
    include("metadata.jl")
    include("matrices.jl")

    @testset "matrices" begin
        for file = readdir("matrices")
            include("matrices/$file")
        end
    end
end
