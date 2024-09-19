"""
Cauchy Matrix
=============
Given two vectors `x` and `y`, the `(i,j)` entry of the Cauchy matrix is
`1/(x[i]+y[j])`.

# Input Options
- x: an integer, as vectors 1:x and 1:x.
- x, y: two integers, as vectors 1:x and 1:y.
- x: a vector. `y` defaults to `x`.
- x, y: two vectors.

# References
**N. J. Higham**, Accuracy and Stability of Numerical Algorithms,
second edition, Society for Industrial and Applied Mathematics,
Philadelphia, PA, USA, 2002, https://doi.org/10.1137/1.9780898718027.
See sect. 28.1.
"""
struct Cauchy{T<:Number,X<:AbstractVector,Y<:AbstractVector} <: AbstractMatrix{T}
    x::X
    y::Y

    function Cauchy{T}(x::AbstractVector{S}, y::AbstractVector{N}) where {T<:Number,S<:Number,N<:Number}
        allunique(x) || throw(ArgumentError("x elements should be unique"))
        allunique(y) || throw(ArgumentError("y elements should be unique"))
        Tc = promote_type(T, S, N)
        return new{Tc,typeof(x),typeof(y)}(x, y)
    end
end

# constructors
Cauchy(x::Integer) = Cauchy(x, x)
Cauchy(x::Integer, y::Integer) = Cauchy([1:x;], [1:y;])
Cauchy(x::AbstractVector) = Cauchy(x, x)
Cauchy(x::AbstractVector{S}, y::AbstractVector{N}) where {S<:Number,N<:Number} = Cauchy{promote_type(S, N)}(x, y)
Cauchy{T}(x::Integer) where {T<:Number} = Cauchy{T}(x, x)
Cauchy{T}(x::Integer, y::Integer) where {T<:Number} = Cauchy{T}([1:x;], [1:y;])
Cauchy{T}(x::AbstractVector) where {T<:Number} = Cauchy{T}(x, x)
Cauchy{T}(x::AbstractVector{S}, y::AbstractVector{N}) where {T<:Integer,S<:Number,N<:Number} = Cauchy{Rational{T}}(x, y)

# metadata
@properties Cauchy [:symmetric, :inverse, :illcond, :posdef, :totpos, :infdiv]

# properties
size(A::Cauchy) = (length(A.x), length(A.y))

# functions
@inline Base.@propagate_inbounds function getindex(A::Cauchy{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return one(T) / T(A.x[i] + A.y[j])
end

# TODO: den may be zero
# https://en.wikipedia.org/wiki/Cauchy_matrix#Cauchy_determinants
# function LinearAlgebra.det(A::Cauchy{T}) where {T}
#     LinearAlgebra.checksquare(A)
#     n = size(A, 1)
#     x = A.x
#     y = A.y

#     num = 1
#     for i = 2:n
#         for j = 1:i-1
#             num *= (x[i] - x[j]) * (y[j] - y[i])
#         end
#     end

#     den = 1
#     for i = 1:n
#         for j = 1:n
#             den *= (x[i] - y[j])
#         end
#     end

#     @show num, den

#     return num / den
# end
