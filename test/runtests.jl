using Test
using TypedMatrices
using LinearAlgebra

const builtin_matrices = list_matrices(Group(:builtin))

function test_matrix_elements(A::AbstractMatrix{T}) where {T}
    return all(typeof(A[i]) == T for i = eachindex(A))
end

function test_linearalgrbra_functions(A::AbstractMatrix)
    matrix = Matrix(A)
    result = Dict([
        isdiag => isdiag(A) == isdiag(matrix),
        ishermitian => ishermitian(A) == ishermitian(matrix),
        issymmetric => issymmetric(A) == issymmetric(matrix),
        isposdef => isposdef(A) == isposdef(matrix),
        adjoint => adjoint(A) ≈ adjoint(matrix),
        transpose => transpose(A) ≈ transpose(matrix),
        det => det(A) == det(matrix),
        inv => inv(A) ≈ inv(matrix),
        eigvals => eigvals(A) ≈ eigvals(matrix),
    ])

    if all(values(result))
        return true
    else
        @error result
        return false
    end
end

if VERSION < v"1.8"
    allequal(itr) = isempty(itr) ? true : all(isequal(first(itr)), itr)
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
