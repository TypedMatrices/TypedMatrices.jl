"""
Cycol Matrix
============
This matrix has columns that repeat cyclically.

# Input Options
- m, n, k: `m` and `n` are size of the matrix. The repeated columns are randn(m, k).
- n, k: `n` is size of the matrix. The repetition is randn(n, k).
- n: `n` is size of the matrix. `k = round(n/4)`
"""
struct Cycol{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    k::Integer
    M::Matrix{T}

    function Cycol{T}(m::Integer, n::Integer, k::Integer) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        k >= 0 || throw(ArgumentError("$k < 0"))
        k <= n || throw(ArgumentError("k > n"))

        k = max(1, k)
        M = randn(T, m, k)
        return new{T}(m, n, k, M)
    end
end

# constructors
Cycol(n::Integer) = Cycol(n, round(Int, n / 4))
Cycol(n::Integer, k::Integer) = Cycol(n, n, k)
Cycol(m::Integer, n::Integer, k::Integer) = Cycol{Float64}(m, n, k)
Cycol{T}(n::Integer) where {T<:Number} = Cycol{T}(n, round(Int, n / 4))
Cycol{T}(n::Integer, k::Integer) where {T<:Number} = Cycol{T}(n, n, k)

# metadata
@properties Cycol [:random, :rankdef] Dict{Vector{Symbol}, Function}(
    [:rectangular] => (n) -> Cycol(2*n, n, 1)
)

# properties
size(A::Cycol) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Cycol{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, 1+mod(j - 1, A.k)]
end
