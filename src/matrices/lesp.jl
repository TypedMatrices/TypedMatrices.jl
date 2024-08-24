"""
Lesp Matrix
===========
A matrix with eigenvalues smoothly distributed in the interval [-2*n-3.5,-4.5].

# Input Options
- dim: the dimension of the matrix.
"""
struct Lesp{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Lesp{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Lesp(n::Integer) = Lesp{Float64}(n)

# metadata
@properties Lesp Symbol[]

# properties
size(A::Lesp) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Lesp{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j - 1
        return T(i + 1)
    elseif i == j
        return -T(i * 2 + 3)
    elseif i == j + 1
        return one(T) / (j + 1)
    else
        return zero(T)
    end
end
