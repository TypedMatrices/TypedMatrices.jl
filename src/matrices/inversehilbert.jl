"""
Inverse of the Hilbert Matrix
=============================
*Input options:*

+ dim: the dimension of the matrix.

*References:*

**M. D. Choi**, Tricks or treats with the Hilbert matrix,
    Amer. Math. Monthly, 90 (1983), pp. 301-312.

**N. J. Higham**, Accuracy and Stability of Numerical Algorithms, second
    edition, Society for Industrial and Applied Mathematics, Philadelphia, PA,
    USA, 2002; sec. 28.1.
"""
struct InverseHilbert{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function InverseHilbert{T}(n::Integer) where {T<:Number}
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(n)
    end
end

# constructors
InverseHilbert(n::Integer) = InverseHilbert{Int}(n)
InverseHilbert{Rational{T}}(n::Integer) where {T} = InverseHilbert{T}(n)

# metadata
@properties InverseHilbert [:symmetric, :inverse, :illcond, :posdef]

# properties
size(A::InverseHilbert) = (A.n, A.n)
LinearAlgebra.ishermitian(A::InverseHilbert) = true
LinearAlgebra.isposdef(A::InverseHilbert) = true
LinearAlgebra.issymmetric(A::InverseHilbert) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::InverseHilbert{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    n = A.n
    out = (-1)^(i + j) * (i + j - 1) * binomial(n + i - 1, n - j) * binomial(n + j - 1, n - i) * binomial(i + j - 2, i - 1)^2
    return T(out)
end

@inline Base.@propagate_inbounds function getindex(A::InverseHilbert{T}, i::Integer, j::Integer) where {T<:Union{BigInt,BigFloat}}
    @boundscheck checkbounds(A, i, j)
    n = big(A.n)
    out = (-1)^(i + j) * (i + j - 1) * binomial(n + i - 1, n - j) * binomial(n + j - 1, n - i) * binomial(big(i + j - 2), i - 1)^2
    return T(out)
end

LinearAlgebra.det(A::InverseHilbert{T}) where {T} = prod(T, (2k + 1) * binomial(2k, k)^2 for k = 1:A.n-1)
LinearAlgebra.det(A::InverseHilbert{T}) where {T<:Union{BigInt,BigFloat}} = prod(T, (2k + 1) * binomial(big(2k), k)^2 for k = 1:A.n-1)

function inv(A::InverseHilbert{T}) where {T}
    HT = promote_type(T, typeof(Rational(one(T))))
    return Hilbert{HT}(A.n)
end
