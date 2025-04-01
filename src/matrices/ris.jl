"""
RIS Matrix
===========
The RIS matrix has `(i,j)` element `0.5/(n-i-j+1.5)`. It is
symmetric.

# Input Options
- dim: the dimension of the matrix.
"""
struct RIS{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function RIS{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
RIS(n::Integer) = RIS{Int}(n)
RIS{T}(n::Integer) where {T<:Integer} = RIS{Rational{T}}(n)

# metadata
@properties RIS [:hankel, :indefinite]

# properties
size(A::RIS) = (A.n, A.n)
LinearAlgebra.issymmetric(::RIS) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::RIS{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(0.5) / T(A.n - i - j + 1.5)
end
