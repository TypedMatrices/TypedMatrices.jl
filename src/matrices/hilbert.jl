"""
Hilbert Matrix
==============
The Hilbert matrix has `(i,j)` element `1/(i+j-1)`. It is
notorious for being ill conditioned. It is symmetric
positive definite and totally positive.

*Input options:*

+ [type,] dim: the dimension of the matrix.

+ [type,] row_dim, col_dim: the row and column dimensions.

*References:*

**M. D. Choi**, Tricks or treats with the Hilbert matrix,
Amer. Math. Monthly, 90 (1983), pp. 301-312.

**N. J. Higham**, Accuracy and Stability of Numerical Algorithms,
second edition, Society for Industrial and Applied Mathematics,
Philadelphia, PA, USA, 2002; sec. 28.1.
"""
struct Hilbert{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer

    function Hilbert(::Type{T}, m::Integer, n::Integer) where {T<:Number}
        m > 0 || throw(ArgumentError("$m ≤ 0"))
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(m, n)
    end
end

# constructors
Hilbert(n::Integer) = Hilbert(n, n)
Hilbert(m::Integer, n::Integer) = Hilbert(Int, m, n)
Hilbert(::Type{T}, n::Integer) where {T<:Number} = Hilbert(T, n, n)
Hilbert(::Type{T}, m::Integer, n::Integer) where {T<:Integer} = Hilbert(Rational{T}, m, n)

# metadata
@properties Hilbert [:symmetric, :inverse, :illcond, :posdef]

# properties
size(A::Hilbert) = (A.m, A.n)
LinearAlgebra.ishermitian(A::Hilbert) = A.m == A.n
LinearAlgebra.isposdef(A::Hilbert) = A.m == A.n
LinearAlgebra.issymmetric(A::Hilbert) = A.m == A.n

# functions
@inline Base.@propagate_inbounds function getindex(A::Hilbert{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return one(T) / (i + j - 1)
end

LinearAlgebra.det(A::Hilbert) = inv(det(inv(A)))
