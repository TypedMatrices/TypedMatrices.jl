"""
Lehmer Matrix
=============
The Lehmer matrix is a symmetric positive definite matrix.
            It is totally nonnegative. The inverse is tridiagonal and
            explicitly known

# Input Options
- dim: the dimension of the matrix.

# References
**M. Newman and J. Todd**, The evaluation of
            matrix inversion programs, J. Soc. Indust. Appl. Math.,
            6 (1958), pp. 466-476.
            Solutions to problem E710 (proposed by D.H. Lehmer): The inverse
            of a matrix, Amer. Math. Monthly, 53 (1946), pp. 534-535.
"""
struct Lehmer{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Lehmer{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Lehmer(n::Integer) = Lehmer{Int}(n)
Lehmer{T}(n::Integer) where {T<:Integer} = Lehmer{Rational{T}}(n)

# metadata
@properties Lehmer [:symmetric, :inverse, :posdef]

# properties
size(A::Lehmer) = (A.n, A.n)
LinearAlgebra.isdiag(A::Lehmer) = A.n <= 1 ? true : false
LinearAlgebra.ishermitian(::Lehmer) = true
LinearAlgebra.isposdef(::Lehmer) = true
LinearAlgebra.issymmetric(::Lehmer) = true
LinearAlgebra.adjoint(A::Lehmer) = A
LinearAlgebra.transpose(A::Lehmer) = A

# functions
@inline Base.@propagate_inbounds function getindex(A::Lehmer{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(min(i, j)) / T(max(i, j))
end
