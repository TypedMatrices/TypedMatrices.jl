"""
Frank Matrix
============
The Frank matrix is an upper Hessenberg matrix with
determinant 1. The eigenvalues are real, positive and
very ill conditioned.

# Input Options
- dim, k: `dim` is the dimension of the matrix, `k = 0 or 1`.
    If `k = 1` the matrix reflect about the anti-diagonal.
- dim: the dimension of the matrix.

# References
**W. L. Frank**, Computing eigenvalues of complex matrices
    by determinant evaluation and by methods of Danilewski and Wielandt,
    J. Soc. Indust. Appl. Math., 6 (1958), pp. 378-392 (see pp. 385, 388).
"""
struct Frank{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer

    function Frank{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k == 0 || k == 1 || throw(ArgumentError("k ≠ 0 or 1"))
        return new{T}(n, k)
    end
end

# constructors
Frank(n::Integer) = Frank(n, 0)
Frank(n::Integer, k::Integer) = Frank{Int}(n, k)
Frank{T}(n::Integer) where {T<:Number} = Frank{T}(n, 0)

# metadata
@properties Frank [:illcond, :eigen]

# properties
size(A::Frank) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Frank{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if A.k == 0 && i <= j
        return T(A.n - j + 1)
    elseif A.k == 1 && i <= j
        return T(i)
    elseif A.k == 0 && i == j + 1
        return T(A.n - j)
    elseif A.k == 1 && i == j + 1
        return T(i - 1)
    else
        return zero(T)
    end
end
