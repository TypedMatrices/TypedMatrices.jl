"""
Pascal Matrix
=============
The Pascal matrix’s anti-diagonals form the Pascal’s triangle.

# Input Options
- dim: the dimension of the matrix.

# References
**R. Brawer and M. Pirovino**, The linear algebra of
    the Pascal matrix, Linear Algebra and Appl., 174 (1992),
    pp. 13-23 (this paper gives a factorization of L = PASCAL(N,1)
               and a formula for the elements of L^k).

**N. J. Higham**, Accuracy and Stability of Numerical Algorithms,
second edition, Society for Industrial and Applied Mathematics, Philadelphia, PA,
USA, 2002. See sect. 28.4.
"""
struct Pascal{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Pascal{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Pascal(n::Integer) = Pascal{Int}(n)

# metadata
@properties Pascal [:symmetric, :inverse, :illcond, :posdef, :eigen, :integer, :totpos]

# properties
size(A::Pascal) = (A.n, A.n)
LinearAlgebra.ishermitian(::Pascal) = true
LinearAlgebra.isposdef(::Pascal) = true
LinearAlgebra.issymmetric(::Pascal) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Pascal{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return binomial(T(i + j - 2), T(j - 1))
end
