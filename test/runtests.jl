using Test
using Suppressor
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

function issquare(A)
    dimensions = size(A)
    return length(dimensions) == 2 && allequal(dimensions)
end
function isbidiagonal(A)
    return issquare(A) && (all(triu(A, 2) .== 0) && all(tril(A, -1) .== 0)) ||
        (all(triu(A, 1) .== 0) && all(tril(A, -2) .== 0))
end
isbinary(A) = length(unique(A)) == 2
function iscirculant(A::AbstractMatrix)
    if ~issquare(A)
        return false
    end
    first_row = A[1, :]
    for i in axes(A, 1)[2:end]
        shifted_row = circshift(first_row, i-1)
        if shifted_row != A[i, :]
            return false
        end
    end
    return true
end
iscomplex(A) = any(imag(A) .!= 0)
function iscorrelation(A)
    if !issquare(A) || !ispositivedefinite(A) || any(diag(A) .!= 1)
        return false
    end
    return true
end
function isdiagdom(A)
    if ~issquare(A)
        return false
    end
    if any(sum(abs, A, dims=2) - 2 * abs.(diag(A)) .> eps() * size(A, 2))
        return false
    end
    return true
end
function ishankel(A)
    if ~issquare(A)
        return false
    end
    for i in 1:size(A, 1)-1
        if A[i,2:end] != A[i+1,1:end-1]
            return false
        end
    end
    return true
end
ishessenberg(A) = eltype(A) <: Integer || all(tril(A, -2) .== 0) || all(triu(A, 2) .== 0)
function isillcond(A)
    if ~issquare(A)
        return false
    end
    return cond(convert(Matrix{Float64}, A)) > size(A, 1) * 100
end
function isindefinite(A)
    if !issquare(A) || !ishermitian(A)
        return false
    end
    eigenvalues = eigvals(A)
    return any(eigenvalues .> eps()) && any(eigenvalues .< -eps())
end
isinteger(A) = all(round.(A) .== A)
function isinvolutory(A)
    if !issquare(A)
        return false
    end
    return A * A ≈ I
end
function isnilpotent(A)
    if !issquare(A)
        return false
    end
    return norm(A^size(A, 1)) ≤ sqrt(eps())
end
isnonneg(A) = all(A .≥ 0)
isnormal(A) =  A' * A ≈ A * A'
isorthogonal(A) = A' * A ≈ I
ispositive(A) = all(A .> 0)
ispositivedefinite(A) = isposdef(convert(Matrix{Float64}, A))
issparse(A) = count(A .!= 0) < prod(size(A)) / 5
isrankdef(A) = rank(A) < minimum(size(A))
isrectangular(A) = !issquare(A)
function istoeplitz(A)
    if ~issquare(A)
        return false
    end
    for i in 1:size(A, 1)-1
        if A[i,1:end-1] != A[i+1,2:end]
            return false
        end
    end
    return true
end
function istotnonneg(A)
    if istotpos(A)
        return false
    end
    n = size(A, 1)
    for k in 1:n
        for i in 1:n-k+1
            for j in 1:n-k+1
                if det(A[i:i+k-1, j:j+k-1]) < 0
                    return false
                end
            end
        end
    end
    return true
end
function istotpos(A)
    n = size(A, 1)
    for k in 1:n
        for i in 1:n-k+1
            for j in 1:n-k+1
                if det(A[i:i+k-1, j:j+k-1]) ≤ 0
                    return false
                end
            end
        end
    end
    return true
end
istriangular(A) = istril(A) || istriu(A)
istridiagonal(A) = all(tril(A, -2) .== 0) && all(triu(A, 2) .== 0)
function isunimodular(A)
    if !issquare(A) || !isinteger(A)
        return false
    end
    return det(A) ≈ 1 || det(A) ≈ -1
end
function_to_check_property = Dict(
    Property(:bidiagonal) => isbidiagonal,
    Property(:binary) => isbinary,
    Property(:circulant) => iscirculant,
    Property(:complex) => iscomplex,
    Property(:correlation) => iscorrelation,
    # Property(:defective) =>     # This property cannot be checked numerically.
    Property(:diagdom) => isdiagdom,
    # Property(:eigen) =>         # This property cannot be checked.
    # Property(:fixedsize) =>     # This property cannot be checked.
    # Property(:graph) =>         # This property cannot be checked.
    Property(:hankel) => ishankel,
    # Property(:hermitian) => # TODO
    Property(:hessenberg) => ishessenberg,
    Property(:illcond) => isillcond,
    Property(:indefinite) => isindefinite,
    #Property(:infdiv) => =       # This property cannot be checked.
    Property(:integer) => isinteger,
    # Property(:inverse) =>       # This property cannot be checked.
    Property(:involutory) => isinvolutory,
    Property(:nilpotent) => isnilpotent,
    Property(:nonneg) => isnonneg,
    Property(:normal) => isnormal,
    Property(:orthogonal) => isorthogonal,
    Property(:positive) => ispositive,
    Property(:posdef) => ispositivedefinite,
    # Property(:possemidef) =>    # This property cannot be checked numerically.
    Property(:random) => nothing, # Needs this, otherwise the property is skipped.
    Property(:rankdef) => isrankdef,
    Property(:rectangular) => isrectangular,
    # Property(:regprob) =>       # This property cannot be checked.
    # Property(:singval) =>       # This property cannot be checked.
    Property(:sparse) => issparse,
    Property(:symmetric) => issymmetric,
    Property(:toeplitz) => istoeplitz,
    Property(:totnonneg) => istotnonneg,
    Property(:totpos) => istotpos,
    Property(:triangular) => istriangular,
    Property(:tridiagonal) => istridiagonal,
    Property(:unimodular) => isunimodular,
    # Property(:unitary) => # TODO
    )

function satisfies_property(A::AbstractMatrix, p::Property)
    return function_to_check_property[p](A)
end

function run_test_properties(matrix_type::Type, sizes::Vector{T}) where T <: Integer
    @test Set(properties(matrix_type)) == Set(properties(matrix_type(Property[], 16)))
    for property in properties(matrix_type)
        if property ∉ keys(function_to_check_property)
            @info "    Skipping $property"
            continue
        end
        @info "    Checking $property"
        for n in sizes
            if n == 1
                continue
            end
            if property == Property(:random)
                ref_matrix = matrix_type([property], n)
                all_matrices_are_equal = true
                for i = 1 : 10
                    if matrix_type([property], n) != ref_matrix
                        all_matrices_are_equal = false
                        break
                    end
                end
                @test !all_matrices_are_equal
            else
                A = matrix_type([property], n)
                @test satisfies_property(A, property)
            end
        end
    end
end
run_test_properties(matrix_type::Type, sizes::UnitRange{T}) where T <: Integer = run_test_properties(matrix_type, collect(sizes))
run_test_properties(matrix_type::Type, n::T) where T <: Integer = run_test_properties(matrix_type, [n])

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
    TEST_CORE = true
    if TEST_CORE
        @testset "core" begin
            include("types.jl")
            include("metadata.jl")
            include("matrices.jl")
            include("interfaces.jl")
        end
    end

    TEST_MATRICES = true
    if TEST_MATRICES
        @testset "matrices" begin
            @testset "$file" for file = readdir("matrices")
                @info "Testing $file"
                include("matrices/$file")
            end
        end
    end
end
