using Test
using TypedMatrices
using LinearAlgebra

const builtin_matrices = list_matrices(Group(:builtin))

macro try_catch(ex::Expr)
    quote
        try
            $(esc(ex))
        catch
        end
    end
end

function test_matrix_elements(A::AbstractMatrix{T}) where {T}
    return all(typeof(A[i]) == T for i = eachindex(A))
end

function test_linearalgrbra_functions(A::AbstractMatrix)
    # variables
    matrix = Matrix(A)
    determinant = det(matrix)
    results = Dict{Function,Bool}()

    # linear algebra functions
    @try_catch results[isdiag] = isdiag(A) == isdiag(matrix)
    @try_catch results[ishermitian] = ishermitian(A) == ishermitian(matrix)
    @try_catch results[issymmetric] = issymmetric(A) == issymmetric(matrix)
    @try_catch results[adjoint] = adjoint(A) ≈ adjoint(matrix)
    @try_catch results[transpose] = transpose(A) ≈ transpose(matrix)
    @try_catch results[det] = det(A) ≈ determinant
    @try_catch results[eigvals] = eigvals(A) ≈ eigvals(matrix)

    # https://github.com/JuliaLang/julia/issues/55404
    if VERSION >= v"1.10"
        @try_catch results[isposdef] = isposdef(A) == isposdef(matrix)

        if determinant != 0
            @try_catch results[inv] = inv(A) ≈ inv(matrix)
        end
    end

    if all(values(results))
        return true
    else
        # error message
        display(A)
        msgs = ["Following functions are not equal for matrix $(typeof(A)):"]
        for (func, result) = results
            if !result
                push!(msgs, "$func(A) = $(func(A)), but $func(matrix) = $(func(matrix))")
            end
        end
        @error join(msgs, "\n")

        return false
    end
end

function run_test_linearalgrbra_functions(matrices::Vector{<:AbstractMatrix})
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
