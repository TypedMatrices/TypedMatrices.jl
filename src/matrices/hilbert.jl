"""
Hilbert Matrix
==============
The Hilbert matrix has `(i,j)` element `1/(i+j-1)`. It is
notorious for being ill conditioned. It is symmetric
positive definite and totally positive.

See also [`InverseHilbert`](@ref).

# Input Options
- dim: the dimension of the matrix.
- row\\_dim, col\\_dim: the row and column dimensions.

# References
**M. D. Choi**, Tricks or treats with the Hilbert matrix,
Amer. Math. Monthly, 90 (1983), pp. 301-312,
https://doi.org/10.1080/00029890.1983.11971218.

**N. J. Higham**, Accuracy and Stability of Numerical Algorithms,
second edition, Society for Industrial and Applied Mathematics,
Philadelphia, PA, USA, 2002. See sect. 28.1.
"""
struct Hilbert{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer

    function Hilbert{T}(m::Integer, n::Integer) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(m, n)
    end
end

# constructors
Hilbert(n::Integer) = Hilbert(n, n)
Hilbert(m::Integer, n::Integer) = Hilbert{Int}(m, n)
Hilbert{T}(n::Integer) where {T<:Number} = Hilbert{T}(n, n)
Hilbert{T}(m::Integer, n::Integer) where {T<:Integer} = Hilbert{Rational{T}}(m, n)

# metadata
@properties Hilbert [:hankel, :illcond, :inverse, :posdef, :totpos]

# properties
size(A::Hilbert) = (A.m, A.n)
LinearAlgebra.ishermitian(A::Hilbert) = A.m == A.n
LinearAlgebra.isposdef(A::Hilbert) = A.m == A.n
LinearAlgebra.issymmetric(A::Hilbert) = A.m == A.n

# functions
@inline Base.@propagate_inbounds function getindex(A::Hilbert{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(one(T) / (i + j - 1))
end

logc(x) = sum([sum(log.(1:i)) for i = 2:(x-1)])
function LinearAlgebra.logdet(A::Hilbert)
    LinearAlgebra.checksquare(A)
    return (4 * logc(A.n) - logc(2 * A.n))
end
LinearAlgebra.det(A::Hilbert) = inv(det(inv(A)))

function inv(A::Hilbert{T}) where {T}
    A.m == A.n || throw(ArgumentError("Works only for square Hilbert matrices."))
    return InverseHilbert{T}(A.n)
end
