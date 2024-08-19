"""
GCDMat Matrix
=============
A matrix with `(i,j)` entry `gcd(i,j)`. It is a symmetric positive
     definite matrix.

# Input Options
- dim: the dimension of the matrix.
"""
struct GCDMat{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function GCDMat{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
GCDMat(n::Integer) = GCDMat{Int}(n)

# metadata
@properties GCDMat [:symmetric, :posdef]

# properties
size(A::GCDMat) = (A.n, A.n)
LinearAlgebra.isdiag(A::GCDMat) = A.n <= 1 ? true : false
LinearAlgebra.ishermitian(::GCDMat) = true
LinearAlgebra.isposdef(::GCDMat) = true
LinearAlgebra.issymmetric(::GCDMat) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::GCDMat{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(gcd(i, j))
end
