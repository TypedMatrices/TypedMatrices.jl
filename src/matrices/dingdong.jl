"""
Dingdong Matrix
===============
The Dingdong matrix is a symmetric Hankel matrix invented
by DR. F. N. Ris of IBM, Thomas J Watson Research Centre.
The eigenvalues cluster around `π/2` and `-π/2`.

*Input options:*

+ dim: the dimension of the matrix.

*References:*

**J. C. Nash**, Compact Numerical Methods for
Computers: Linear Algebra and Function Minimisation,
second edition, Adam Hilger, Bristol, 1990 (Appendix 1).
"""
struct DingDong{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function DingDong{T}(n::Integer) where {T<:Number}
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(n)
    end
end

# constructors
DingDong(n::Integer) = DingDong{Int}(n)
DingDong{T}(n::Integer) where {T<:Integer} = DingDong{Rational{T}}(n)

# metadata
@properties DingDong [:symmetric, :eigen]

# properties
size(A::DingDong) = (A.n, A.n)
LinearAlgebra.issymmetric(::DingDong) = true
LinearAlgebra.ishermitian(::DingDong) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::DingDong{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(one(T) / (2 * (A.n - i - j + T(1.5))))
end
