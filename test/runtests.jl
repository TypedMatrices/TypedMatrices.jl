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
    if !issquare(A) || !isposdef(A) || any(diag(A) .!= 1)
        return false
    end
    return true
end
function isdiagdom(A)
    if ~issquare(A)
        return false
    end
    if any(sum(abs, A, dims=2) - 2 * abs.(diag(A)) .> 0)
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
ishessenberg(A) = !istridiagonal(A) && !istriangular(A) && (all(tril(A, -2) .== 0) || all(triu(A, 2) .== 0))
function isillcond(A)
    if ~issquare(A)
        return false
    end
    return cond(A) > size(A, 1) * 100
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
isnonneg(A) = all(A .≥ 0) && !ispositive(A) && !istotnonneg(A) && !istotpos(A)
isnormal(A) =  A' * A ≈ A * A' && !issymmetric(A)
isorthogonal(A) = A' * A ≈ I
ispositive(A) = all(A .> 0) && !istotpos(A)
issparse(A) = count(A .!= 0) < prod(size(A)) / 10
isrankdef(A) = rank(A) < minimum(size(A))
isrectangular(A) = !issquare(A)
function istoeplitz(A)
    if ~issquare(A) || iscirculant(A)
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
    # Property(:defective) => # This property cannot be checked numerically.
    Property(:diagdom) => isdiagdom,
    # Property(:eigen) =>     # This property cannot be checked.
    # Property(:fixedsize) => # This property cannot be checked.
    # Property(:graph) =>     # This property cannot be checked.
    Property(:hankel) => ishankel,
    Property(:hessenberg) => ishessenberg,
    Property(:illcond) => isillcond,
    Property(:indefinite) => isindefinite,
    #Property(:infdiv) => =   # This property cannot be checked.
    Property(:integer) => isinteger,
    # Property(:inverse) =>   # This property cannot be checked.
    Property(:involutory) => isinvolutory,
    Property(:nilpotent) => isnilpotent,
    Property(:nonneg) => isnonneg,
    Property(:normal) => isnormal,
    Property(:orthogonal) => isorthogonal,
    Property(:positive) => ispositive,
    Property(:posdef) => isposdef,
    # Property(:random) =>    # This property cannot be checked.
    Property(:rankdef) => isrankdef,
    Property(:rectangular) => isrectangular,
    # Property(:regprob) =>   # This property cannot be checked.
    # Property(:singval) =>   # This property cannot be checked.
    Property(:sparse) => issparse,
    Property(:symmetric) => issymmetric,
    Property(:toeplitz) => istoeplitz,
    Property(:totnonneg) => istotnonneg,
    Property(:totpos) => istotpos,
    Property(:triangular) => istriangular,
    Property(:tridiagonal) => istridiagonal,
    Property(:unimodular) => isunimodular
    )

function satisfies_property(A::AbstractMatrix, p::Property)
    return function_to_check_property[p](A)
end

function test_properties(A::AbstractMatrix)
    all_properties = keys(function_to_check_property)
    matrix_properties = properties(A)
    print(matrix_properties)
    if size(A) == (1, 1) # Some properties are always true for scalars.
        return
    end
    for property in all_properties
        @info "Checking $property"
        @test (property in matrix_properties) == satisfies_property(A, property)
    end
end

function run_test_properties(matrices::Vector{<:AbstractMatrix})
    for matrix = matrices
        run_test_properties(matrix)
    end
end
function run_test_properties(matrix::AbstractMatrix)
    test_properties(matrix)
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
    if !issquare(A) || !isposdef(A) || any(diag(A) .!= 1)
        return false
    end
    return true
end
function isdiagdom(A)
    if ~issquare(A)
        return false
    end
    if any(sum(abs, A, dims=2) - 2 * abs.(diag(A)) .> 0)
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
ishessenberg(A) = !istridiagonal(A) && !istriangular(A) && (all(tril(A, -2) .== 0) || all(triu(A, 2) .== 0))
function isillcond(A)
    if ~issquare(A)
        return false
    end
    return cond(A) > size(A, 1) * 100
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
isnonneg(A) = all(A .≥ 0) && !ispositive(A) && !istotnonneg(A) && !istotpos(A)
isnormal(A) =  A' * A ≈ A * A' && !issymmetric(A)
isorthogonal(A) = A' * A ≈ I
ispositive(A) = all(A .> 0) && !istotpos(A)
issparse(A) = count(A .!= 0) < prod(size(A)) / 10
isrankdef(A) = rank(A) < minimum(size(A))
isrectangular(A) = !issquare(A)
function istoeplitz(A)
    if ~issquare(A) || iscirculant(A)
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
    # Property(:defective) => # This property cannot be checked numerically.
    Property(:diagdom) => isdiagdom,
    # Property(:eigen) =>     # This property cannot be checked.
    # Property(:fixedsize) => # This property cannot be checked.
    # Property(:graph) =>     # This property cannot be checked.
    Property(:hankel) => ishankel,
    Property(:hessenberg) => ishessenberg,
    Property(:illcond) => isillcond,
    Property(:indefinite) => isindefinite,
    #Property(:infdiv) => =   # This property cannot be checked.
    Property(:integer) => isinteger,
    # Property(:inverse) =>   # This property cannot be checked.
    Property(:involutory) => isinvolutory,
    Property(:nilpotent) => isnilpotent,
    Property(:nonneg) => isnonneg,
    Property(:normal) => isnormal,
    Property(:orthogonal) => isorthogonal,
    Property(:positive) => ispositive,
    Property(:posdef) => isposdef,
    # Property(:random) =>    # This property cannot be checked.
    Property(:rankdef) => isrankdef,
    Property(:rectangular) => isrectangular,
    # Property(:regprob) =>   # This property cannot be checked.
    # Property(:singval) =>   # This property cannot be checked.
    Property(:sparse) => issparse,
    Property(:symmetric) => issymmetric,
    Property(:toeplitz) => istoeplitz,
    Property(:totnonneg) => istotnonneg,
    Property(:totpos) => istotpos,
    Property(:triangular) => istriangular,
    Property(:tridiagonal) => istridiagonal,
    Property(:unimodular) => isunimodular
    )

function satisfies_property(A::AbstractMatrix, p::Property)
    return function_to_check_property[p](A)
end

function test_properties(A::AbstractMatrix)
    all_properties = keys(function_to_check_property)
    matrix_properties = properties(A)
    print(matrix_properties)
    if size(A) == (1, 1) # Some properties are always true for scalars.
        return
    end
    for property in all_properties
        @info "Checking $property"
        @test (property in matrix_properties) == satisfies_property(A, property)
    end
end

function run_test_properties(matrices::Vector{<:AbstractMatrix})
    for matrix = matrices
        run_test_properties(matrix)
    end
end
function run_test_properties(matrix::AbstractMatrix)
    test_properties(matrix)
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
    end

    @testset "matrices" begin
        @testset "$file" for file = readdir("matrices")
            @info "Testing $file"
            include("matrices/$file")
        end
    end
end
