"""
Hanowa Matrix
=============
The Hanowa matrix is a matrix whose eigenvalues lie
on a vertical line in the complex plane.

# Input Options
- dim: the dimension of the matrix and `alpha = -1`.
- dim, alpha: the dimension and alpha.
"""
struct Hanowa{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T

    function Hanowa{T}(n::Integer, alpha::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        n % 2 == 0 || throw(ArgumentError("n must be even"))
        return new{T}(n, alpha)
    end
end

# constructors
Hanowa(n::Integer) = Hanowa(n, -1)
Hanowa(n::Integer, alpha::T) where {T<:Number} = Hanowa{T}(n, alpha)
Hanowa{T}(n::Integer) where {T<:Number} = Hanowa{T}(n, T(-1))

# metadata
@properties Hanowa [:eigen]

# properties
size(A::Hanowa) = (A.n, A.n)
LinearAlgebra.issymmetric(A::Hanowa) = A.n <= 1 ? true : false

# functions
@inline Base.@propagate_inbounds function getindex(A::Hanowa{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    half_n = A.n / 2
    if i == j
        return A.alpha
    elseif i == j - half_n
        return -T(j - half_n)
    elseif i == j + half_n
        return T(i - half_n)
    else
        return zero(T)
    end
end
