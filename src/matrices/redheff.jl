"""
Redheffer Matrix
================
Redheffer matrix of 1s and 0s.

# Input Options
- dim: the dimension of the matrix.
"""
struct Redheff{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Redheff{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Redheff(n::Integer) = Redheff{Int}(n)

# metadata
@properties Redheff Symbol[:binary, :nonneg, :eigen]

# properties
size(A::Redheff) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Redheff{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if j == 1 || j % i == 0
        return one(T)
    else
        return zero(T)
    end
end
