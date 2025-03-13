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

function test_linear_algebra_functions(A::AbstractMatrix)
    # variables
    matrix = Matrix(A)
    determinant = det(matrix)
    results = Dict{Function,Bool}()

    # linear algebra functions
    property_functions = [isdiag, ishermitian, issymmetric]
    # https://github.com/JuliaLang/julia/issues/55404
    if VERSION >= v"1.10"
        append!(property_functions, [isposdef])
    end
    for func in property_functions
        @try_catch results[func] = func(A) == func(matrix)
    end

    computation_functions = [adjoint, transpose, det, logdet, eigvals]
    if determinant != 0
        append!(computation_functions, [inv])
    end
    for func in computation_functions
        @try_catch results[func] = func(A) ≈ func(matrix)
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

function run_test_linear_algebra_functions(matrices::Vector{<:AbstractMatrix})
    for matrix = matrices
        @test test_linear_algebra_functions(matrix)
    end
end

if VERSION < v"1.8"
    allequal(itr) = isempty(itr) ? true : all(isequal(first(itr)), itr)
end

@testset "TypedMatrices.jl" begin
    SINGLE_TEST = false
    if SINGLE_TEST
        NAME = "hilbert"
        @info "Testing $NAME"
        include("matrices/$NAME.jl")
        return
    end

    @info "Testing core features"
    @testset "core" begin
        include("types.jl")
        include("metadata.jl")
        include("matrices.jl")
        include("interfaces.jl")
    end

    @testset "matrices" begin
        @testset "$file" for file = readdir("matrices")
            @info "Testing $file"
            include("matrices/$file")
        end
    end
end
