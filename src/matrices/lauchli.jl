"""
Lauchli Matrix
===============
A matrix with ones on the first row, `mu` on the subdiagonal, and zeros elsewhere.

# Input Options
- dim: the dimension of the matrix. `mu = sqrt(eps())` by default.
- dim, mu: the dimension and subdiagonal value of the matrix.
"""
struct Lauchli{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    mu::T

    function Lauchli{T}(n::Integer, mu::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n + 1, n, mu)
    end
end

# constructor
Lauchli(n::Integer) = Lauchli(n, sqrt(eps()))
Lauchli(n::Integer, mu::T) where {T<:Number} = Lauchli{T}(n, mu)
Lauchli{T}(n::Integer) where {T<:Number} = Lauchli{T}(n, sqrt(eps(T)))

# metadata
@properties Lauchli Symbol[:rectangular]

# properties
size(A::Lauchli) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Lauchli{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == 1
        return one(T)
    elseif i == j + 1
        return A.mu
    else
        return zero(T)
    end
end
