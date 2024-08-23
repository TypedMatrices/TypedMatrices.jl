"""
Smoke Matrix
============
Complex matrix with a "smoke ring" pseudospectrum.
1's on the superdiagonal, cos(w) + sin(w) * im on the diagonal.
The `A(n, 1)`` entry is 1 if k = 0, 0 if k = 1.

# Input Options
- dim: dimension of the matrix. `k = 0`.
- dim, k: dimension of the matrix and the k.
"""
struct Smoke{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer
    w::Vector

    function Smoke{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k ∈ 0:1 || throw(ArgumentError("$k ∉ 0:1"))
        w = (2:2:2*n) / n
        return new{T}(n, k, w)
    end
end

# constructors
Smoke(n::Integer) = Smoke(n, 0)
Smoke(n::Integer, k::Integer) = Smoke{Complex{Float64}}(n, k)
Smoke{T}(n::Integer) where {T<:Number} = Smoke{T}(n, 0)
Smoke{T}(n::Integer, k::Integer) where {T<:AbstractFloat} = Smoke{Complex{T}}(n, k)

# metadata
@properties Smoke [:symmetric]

# properties
size(A::Smoke) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Smoke{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j
        return T(cospi(A.w[i]) + sinpi(A.w[i]) * im)
    elseif i == j - 1
        return one(T)
    elseif i == A.n && j == 1
        return A.k == 0 ? one(T) : zero(T)
    else
        return zero(T)
    end
end
