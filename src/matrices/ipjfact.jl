"""
Ipjfact Matrix
==============
Hankel matrix with factorial elements.

# Input Options
- dim: the dimension of the matrix.
- dim, k:
    `k = 0` element `(i, j)` is `factorial(i + j)`.
    `k = 1` element `(i, j)` is `1 / factorial(i + j)`.
"""
struct Ipjfact{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer

    function Ipjfact{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k ∈ 0:1 || throw(ArgumentError("$k ∉ 0:1"))
        return new{T}(n, k)
    end
end

# constructors
Ipjfact(n::Integer) = Ipjfact(n, 0)
Ipjfact(n::Integer, k::Integer) = Ipjfact{Int}(n, k)
Ipjfact{T}(n::Integer) where {T<:Number} = Ipjfact{T}(n, 0)

# metadata
@properties Ipjfact [:symmetric, :posdef, :hankel, :illcond, :positive]

# properties
size(A::Ipjfact) = (A.n, A.n)
LinearAlgebra.issymmetric(::Ipjfact) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Ipjfact{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if A.k == 0
        return T(factorial(i + j))
    elseif A.k == 1
        return T(1 / factorial(i + j))
    end
end
