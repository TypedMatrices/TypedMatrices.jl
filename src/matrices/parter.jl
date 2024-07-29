"""
Parter Matrix
=============
The Parter matrix is a Toeplitz and Cauchy matrix
            with singular values near `π`.

*Input options:*

+ dim: the dimension of the matrix.

*References:*

The MathWorks Newsletter, Volume 1, Issue 1,
            March 1986, page 2. S. V. Parter, On the distribution of the
            singular values of Toeplitz matrices, Linear Algebra and
            Appl., 80 (1986), pp. 115-130.
"""
struct Parter{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Parter{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Parter(n::Integer) = Parter{Int}(n)
Parter{T}(n::Integer) where {T<:Integer} = Parter{Rational{T}}(n)

# metadata
@properties Parter [:eigen]

# properties
size(A::Parter) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Parter{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return one(T) / T(i - j + 0.5)
end
