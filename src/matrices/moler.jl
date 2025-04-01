"""
Moler Matrix
============
The Moler matrix is a symmetric positive definite matrix.
It has one small eigenvalue.

# Input Options
- dim, alpha: `dim` is the dimension of the matrix,
        `alpha` is a scalar.
- dim: `alpha = -1`.

# References
**J.C. Nash**, Compact Numerical Methods for Computers:
Linear Algebra and Function Minimisation, second edition,
Adam Hilger, Bristol, 1990 (Appendix 1).
"""
struct Moler{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T
    M::Matrix{T}

    function Moler{T}(n::Integer, alpha::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        triw = Triw{T}(n, alpha)
        M = transpose(triw) * triw
        return new{T}(n, alpha, M)
    end
end

# constructors
Moler(n::Integer) = Moler{Float64}(n, -1)
Moler(n::Integer, alpha::T) where {T<:Number} = Moler{T}(n, alpha)
Moler{T}(n::Integer) where {T<:Number} = Moler{T}(n, -1)
Moler{T}(n::Integer, alpha::Number) where {T<:Number} = Moler{T}(n, convert(T, alpha))

# metadata
@properties Moler [:illcond, :integer, :inverse, :posdef]

# properties
size(A::Moler) = (A.n, A.n)
LinearAlgebra.issymmetric(::Moler) = true
LinearAlgebra.isposdef(::Moler) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Moler{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
