"""
Triw Matrix
===========
Upper triangular matrices discussed by Wilkinson and others.

# Input Options
- row_dim, col_dim, α, k: `row_dim` and `col_dim`
        are row and column dimension of the matrix. `α` is a
        scalar representing the entries on the superdiagonals.
        `k` is the number of superdiagonals.
- dim: the dimension of the matrix.

# References
**G. H. Golub and J. H. Wilkinson**, Ill-conditioned
eigensystems and the computation of the Jordan canonical form,
SIAM Review, 18(4), 1976, pp. 578-6
"""
struct Triw{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T
    k::Integer

    function Triw{T}(n::Integer, alpha::T, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k >= 0 || throw(ArgumentError("$k < 0"))
        return new{T}(n, alpha, k)
    end
end

# constructors
Triw(n::Integer) = Triw(n, -1, n - 1)
Triw(n::Integer, alpha::T) where {T<:Number} = Triw(n, alpha, n - 1)
Triw(n::Integer, alpha::T, k::Integer) where {T<:Number} = Triw{T}(n, alpha, k)
Triw{T}(n::Integer) where {T<:Number} = Triw{T}(n, -1, n - 1)
Triw{T}(n::Integer, alpha::Number) where {T<:Number} = Triw{T}(n, alpha, n - 1)
Triw{T}(n::Integer, alpha::Number, k::Integer) where {T<:Number} = Triw{T}(n, convert(T, alpha), k)

# metadata
@properties Triw [:inverse, :illcond]

# properties
size(A::Triw) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Triw{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i > j
        return zero(T)
    elseif i == j
        return one(T)
    elseif i < j <= i + A.k
        return A.alpha
    else
        return zero(T)
    end
end
