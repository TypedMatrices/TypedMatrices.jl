"""
Leslie Matrix
==============
Matrix for birth numbers and survival rates in the Leslie population model.

# Input Options
- dim: the dimension of the matrix. `x = ones(n)` and `y = ones(n - 1)` by default.
- x, y: x and y.
"""
struct Leslie{T<:Number} <: AbstractMatrix{T}
    n::Integer
    x::Vector{T}
    y::Vector{T}

    function Leslie(x::AbstractVector{T}, y::AbstractVector{T}) where {T<:Number}
        n = length(x)
        n - 1 == length(y) || throw(DimensionMismatch("length of y must be equal to length of x - 1"))
        return new{T}(n, x, y)
    end
end

# constructor
Leslie(n::Integer) = Leslie{Int}(n)
Leslie{T}(n::Integer) where {T<:Number} = Leslie(ones(T, n), ones(T, n - 1))

# metadata
@properties Leslie Symbol[]

# properties
size(A::Leslie) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Leslie{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == 1
        return A.x[j]
    elseif i == j + 1
        return A.y[j]
    else
        return zero(T)
    end
end
