"""
Chow Matrix
===========
The Chow matrix is a singular Toeplitz lower Hessenberg matrix.

# Input Options
- dim, alpha, delta: `dim` is dimension of the matrix.
            `alpha`, `delta` are scalars such that `A[i,i] = alpha + delta` and
            `A[i,j] = alpha^(i + 1 -j)` for `j + 1 <= i`.
- dim: `alpha = 1`, `delta = 0`.

# References
**T. S. Chow**, A class of Hessenberg matrices with known
                eigenvalues and inverses, SIAM Review, 11 (1969), pp. 391-395.
"""
struct Chow{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T
    delta::T

    function Chow{T}(n::Integer, alpha, delta) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, convert(T, alpha), convert(T, delta))
    end
end

# constructors
Chow(n::Integer) = Chow(n, 1, 0)
Chow(n::Integer, alpha, delta) = Chow{Int}(n, alpha, delta)
Chow{T}(n::Integer) where {T<:Number} = Chow{T}(n, 1, 0)

# metadata
@properties Chow [:hessenberg, :toeplitz, :binary, :eigen, :rankdef]

# properties
size(A::Chow) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Chow{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j - 1
        return one(T)
    elseif i == j
        return A.alpha + A.delta
    elseif j + 1 <= i
        return A.alpha^(i + 1 - j)
    else
        return zero(T)
    end
end
