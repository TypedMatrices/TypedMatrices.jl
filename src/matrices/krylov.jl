"""
Krylov Matrix
=============
The basis of a Krylow subspace. The matrix has columns
`[x, A*x, A^2*x, ..., A^(k-1)*x]`.

# Input Options
- dim: dimension of the matrix. `A = randn(dim, dim)`. `x = ones(dim)`. `k = dim`.
- dim, x: dimension of the matrix and x.
- dim, x, k: dimension of the matrix, x and k.
- A: matrix. `x = ones(size(A, 1))`. `k = size(A, 1)`.
- A, x: matrix and x. `k = size(A, 1)`.
- A, x, k: matrix, x, and k.
"""
struct Krylov{T<:Number} <: AbstractMatrix{T}
    n::Integer
    A::AbstractMatrix{T}
    x::Vector{T}
    k::Integer
    M::AbstractMatrix{T}

    function Krylov(A::AbstractMatrix{T}, x::Vector{T}, k::Integer) where {T<:Number}
        m, n = size(A)
        m == n || throw(DimensionMismatch("A is not square"))
        n >= 0 || throw(ArgumentError("$n < 0"))

        # generate matrix
        M = zeros(T, n, k)
        x1 = copy(x)
        for i = 1:k
            M[:, i] = x1
            x1 = A * x1
        end

        return new{T}(n, A, x, k, M)
    end
end

# constructor
Krylov(n::Integer) = Krylov(randn(n, n))
Krylov(n::Integer, x::Vector{T}) where {T<:Number} = Krylov(randn(T, n, n), x, n)
Krylov(n::Integer, x::Vector{T}, k::Integer) where {T<:Number} = Krylov(randn(T, n, n), x, k)
function Krylov(A::AbstractMatrix{T}) where {T<:Number}
    n = size(A, 1)
    x = ones(T, n)
    return Krylov(A, x, n)
end
Krylov{T}(n::Integer) where {T<:Number} = Krylov(randn(T, n, n))
Krylov{T}(n::Integer, x::Vector{T}) where {T<:Number} = Krylov(randn(T, n, n), x, n)
Krylov{T}(n::Integer, x::Vector{T}, k::Integer) where {T<:Number} = Krylov(randn(T, n, n), x, k)

# metadata
@properties Krylov [:random] Dict{Vector{Symbol}, Function}(
    [] => (n) -> Krylov(n),
    [:rectangular] => (n) -> Krylov(2*n, randn(2*n), n)
)

# properties
size(A::Krylov) = (A.n, A.k)

# functions
@inline Base.@propagate_inbounds function getindex(A::Krylov{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
