# TODO: Randjorth Matrix
"""
Randjorth Matrix
================
This matrix is currently not implemented.
"""
struct Randjorth{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Randjorth{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Randjorth(n::Integer) = Randjorth{Float64}(n)

# metadata
@properties Randjorth [:random]

# properties
size(A::Randjorth) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Randjorth{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return zero(T)
end
