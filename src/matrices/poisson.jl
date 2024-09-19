"""
Poisson Matrix
==============
A block tridiagonal matrix from Poisson’s equation.
     This matrix is sparse, symmetric positive definite and
     has known eigenvalues.

# Input Options
- dim: the dimension of the matrix.

# References
**G. H. Golub and C. F. Van Loan**, Matrix Computations,
second edition, Johns Hopkins University Press, Baltimore,
Maryland, 1989. See sect. 4.5.4.
"""
struct Poisson{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::Matrix{T}

    function Poisson{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        # get sqrt of n
        sqrtn = sqrt(n)
        isinteger(sqrtn) || throw(ArgumentError("$n is not a perfect square integer"))
        sqrtn = Int(sqrtn)

        # generate matrix
        S = Tridiagonal(-ones(T, sqrtn - 1), T(2) * ones(T, sqrtn), -ones(T, sqrtn - 1))
        A = Matrix(I, sqrtn, sqrtn)
        M = kron(A, S) + kron(S, A)

        return new{T}(n, M)
    end
end

# constructors
Poisson(n::Integer) = Poisson{Int}(n)

# metadata
@properties Poisson [:symmetric, :inverse, :posdef, :eigen, :sparse]

# properties
size(A::Poisson) = (A.n, A.n)
LinearAlgebra.ishermitian(::Poisson) = true
LinearAlgebra.isposdef(::Poisson) = true
LinearAlgebra.issymmetric(::Poisson) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Poisson{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
