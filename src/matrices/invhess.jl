"""
Invhess Matrix
==============
Inverse of upper Hessenberg matrix.

# Input Options
- dim: the dimension of the matrix. `x = [1:dim;]`.
- x: x vector. `y = -x[1:end-1]`.
- x, y: x and y vectors.
"""
struct Invhess{T<:Number} <: AbstractMatrix{T}
    n::Integer
    x::Vector{T}
    y::Vector{T}

    function Invhess(x::AbstractVector{T}, y::AbstractVector{T}) where {T<:Number}
        n = length(x)
        n - 1 == length(y) || throw(DimensionMismatch("length of y must be one less than length of x"))
        return new{T}(n, x, y)
    end
end

# constructors
Invhess(n::Integer) = Invhess([1:n;])
Invhess(x::AbstractVector) = Invhess(x, -x[1:end-1])
Invhess{T}(n::Integer) where {T<:Number} = Invhess(T[1:n;])

# metadata
@properties Invhess Symbol[:integer]

# properties
size(A::Invhess) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Invhess{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i >= j
        return A.x[j]
    else
        return A.y[i]
    end
end
