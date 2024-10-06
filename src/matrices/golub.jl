"""
Golub Matrix
============
The Golub matrix is the product of two random matrices, the first is
unit lower triangular and the second is upper triangular. The LU
factorization without pivoting fails to reveal that such matrices
are badly conditioned.

# Input Options
- dim: the dimension of the matrix.

# References
**D. Viswanath and N. Trefethen**. Condition numbers of random
triangular matrices, SIAM J. Matrix Anal. Appl., 19 (1998), 564-581,
https://doi.org/10.1137/S0895479896312869.
"""
struct Golub{T<:Number} <: AbstractMatrix{T}
    n::Integer
    A::Matrix{T}

    function Golub{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        # generate random matrix
        s = 10
        L = Array{T,2}(undef, n, n)
        U = Array{T,2}(undef, n, n)
        if T <: Integer
            [L[i, j] = round(T, s * randn(), RoundNearestTiesAway) for j = 1:n, i = 1:n]
            [U[i, j] = round(T, s * randn(), RoundNearestTiesAway) for j = 1:n, i = 1:n]
        else
            [L[i, j] = s * randn() for j = 1:n, i = 1:n]
            [U[i, j] = s * randn() for j = 1:n, i = 1:n]
        end
        L = tril(L, -1) + Matrix{T}(I, n, n)
        U = triu(U, 1) + Matrix{T}(I, n, n)
        A = L * U

        return new{T}(n, A)
    end
end

# constructors
Golub(n::Integer) = Golub{Float64}(n)

# metadata
@properties Golub [:illcond, :random]

# properties
size(A::Golub) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Golub{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.A[i, j]
end
