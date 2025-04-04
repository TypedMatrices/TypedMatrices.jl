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
**G. H. Golub and J. H. Wilkinson**, Ill-conditioned eigensystems
and the computation of the Jordan canonical form, SIAM Rev., 18
(1976), pp. 578-619, https://doi.org/10.1137/1018113.
"""
struct Triw{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    alpha::T
    k::Integer

    function Triw{T}(m::Integer, n::Integer, alpha::T, k::Integer) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        k >= 0 || throw(ArgumentError("$k < 0"))
        return new{T}(m, n, alpha, k)
    end
end

# constructors
Triw(n::Integer) = Triw(n, n, -1, n - 1)
Triw(m::Integer, n::Integer) = Triw(m, n, -1, n - 1)
Triw(m::Integer, n::Integer, alpha::T) where {T<:Number} = Triw(m, n, alpha, n - 1)
Triw(m::Integer, n::Integer, alpha::T, k::Integer) where {T<:Number} = Triw{T}(m, n, alpha, k)

Triw{T}(n::Integer) where {T<:Number} = Triw{T}(n, n, -1, n - 1)
Triw{T}(m::Integer, n::Integer) where {T<:Number} = Triw{T}(m, n, -1, n - 1)
Triw{T}(m::Integer, n::Integer, alpha::T) where {T<:Number} = Triw(m, n, alpha, n - 1)
Triw{T}(m::Integer, n::Integer, alpha::Number, k::Integer) where {T<:Number} = Triw{T}(m, n, convert(T, alpha), k)

# metadata
@properties Triw [:defective, :inverse, :triangular] Dict{Vector{Symbol}, Function}(
    [:rectangular] => (n) -> Triw(2 * n, n),
    [:hessenberg] => (n) -> Triw(n, n, 0.5, 1),
    [:illcond] => (n) -> Triw(n, n , -3)
)

# properties
size(A::Triw) = (A.m, A.n)

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
