"""
Kac-Murdock-Szego Toeplitz matrix
=================================

*Input options:*

+ dim, rho: `dim` is the dimension of the matrix, `rho` is a
    scalar such that `A[i,j] = rho^(abs(i-j))`.

+ dim: `rho = 0.5`.

*References:*

**W. F. Trench**, Numerical solution of the eigenvalue
    problem for Hermitian Toeplitz matrices, SIAM J. Matrix Analysis
    and Appl., 10 (1989), pp. 135-146 (and see the references therein).
"""
struct KMS{T<:Number} <: AbstractMatrix{T}
    n::Integer
    rho::T

    function KMS{T}(n::Integer, rho::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, rho)
    end
end

# constructors
KMS(n::Integer) = KMS(n, 0.5)
KMS(n::Integer, rho::Number) = KMS{typeof(rho)}(n, rho)
KMS{T}(n::Integer, rho::Number) where {T} = KMS{T}(n, convert(T, rho))

# metadata
@properties KMS [:symmetric, :inverse, :illcond, :posdef]

# properties
size(A::KMS) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::KMS{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    element = A.rho^(abs(i - j))
    if i > j && typeof(A.rho) <: Complex
        return conj(element)
    else
        return element
    end
end
