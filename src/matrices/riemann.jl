"""
Riemann Matrix
==============
A matrix associated with the Riemann hypothesis.

# Input Options
- dim: the dimension of the matrix.
"""
struct Riemann{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Riemann{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Riemann(n::Integer) = Riemann{Int}(n)

# metadata
@properties Riemann Symbol[]

# properties
size(A::Riemann) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Riemann{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if (j + 1) % (i + 1) == 0
        return T(i)
    else
        return T(-1)
    end
end
