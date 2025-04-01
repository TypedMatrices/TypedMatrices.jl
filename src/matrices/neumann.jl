"""
Neumann Matrix
==============
A singular matrix from the discrete Neumann problem.
       The matrix is sparse and the null space is formed by a vector of ones

# Input Options
- dim: the dimension of the matrix, must be a perfect square integer.

# References
**R. J. Plemmons**, Regular splittings and the discrete Neumann problem,
Numer. Math., 25 (1976), pp. 153-161, https://doi.org/10.1007/BF01462269.
"""
struct Neumann{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::Matrix{T}

    function Neumann{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        # 0 and 1
        if n == 0
            return new{T}(n, Matrix{T}(undef, 0, 0))
        elseif n == 1
            return new{T}(n, 4 * ones(T, 1, 1))
        end

        # get sqrt of n
        sqrtn = sqrt(n)
        isinteger(sqrtn) || throw(ArgumentError("$n is not a perfect square integer"))
        sqrtn = Int(sqrtn)

        # generate matrix
        S = Tridiagonal(-ones(T, sqrtn - 1), T(2) * ones(T, sqrtn), -ones(T, sqrtn - 1))
        S[1, 2] = -2
        S[sqrtn, sqrtn-1] = -2
        A = Matrix(I, sqrtn, sqrtn)
        M = kron(S, A) + kron(A, S)

        return new{T}(n, M)
    end
end

# constructors
Neumann(n::Integer) = Neumann{Int}(n)

# metadata
@properties Neumann [:diagdom, :eigen, :sparse, :rankdef]

# properties
size(A::Neumann) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Neumann{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
