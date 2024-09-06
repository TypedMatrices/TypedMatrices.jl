"""
Pei Matrix
==========
The Pei matrix is a symmetric matrix with known inversion.

# Input Options
- dim, alpha: `dim` is the dimension of the matrix.
    `alpha` is a scalar.
- dim: the dimension of the matrix.

# References
**M. L. Pei**, A test matrix for inversion procedures,
    Comm. ACM, 5 (1962), p. 508.
"""
struct Pei{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T

    function Pei{T}(n::Integer, alpha::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, alpha)
    end
end

# constructors
Pei(n::Integer) = Pei(n, 1)
Pei(n::Integer, alpha::T) where {T<:Number} = Pei{T}(n, alpha)
Pei{T}(n::Integer) where {T<:Number} = Pei{T}(n, one(T))

# metadata
@properties Pei [:symmetric, :inverse, :posdef, :integer, :positive]

# properties
size(A::Pei) = (A.n, A.n)
LinearAlgebra.issymmetric(::Pei) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Pei{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return i == j ? A.alpha + one(T) : one(T)
end
