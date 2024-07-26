"""
Forsythe Matrix
===============
The Forsythe matrix is a n-by-n perturbed Jordan block.
This generator is adapted from N. J. Higham's Test Matrix Toolbox.

*Input options:*

+ dim, alpha, lambda: `dim` is the dimension of the matrix.
    `alpha` and `lambda` are scalars.

+ dim: `alpha = sqrt(eps(type))` and `lambda = 0`.
"""
struct Forsythe{T<:Number} <: AbstractMatrix{T}
    n::Integer
    alpha::T
    lambda::T

    function Forsythe{T}(n::Integer, alpha::T, lambda::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, alpha, lambda)
    end
end

# constructors
Forsythe(n::Integer) = Forsythe{Float64}(n)
Forsythe{T}(n::Integer) where {T<:AbstractFloat} = Forsythe{T}(n, sqrt(eps(T)), zero(T))
function Forsythe(n::Integer, alpha::Number, lambda::Number)
    Ta = typeof(alpha)
    Tl = typeof(lambda)
    T = promote_type(Ta, Tl)
    return Forsythe{T}(n, convert(T, alpha), convert(T, lambda))
end

# metadata
@properties Forsythe [:inverse, :illcond, :eigen]

# properties
size(A::Forsythe) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Forsythe{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j
        return A.lambda
    elseif i == j - 1
        return one(T)
    elseif i == A.n && j == 1
        return A.alpha
    else
        return zero(T)
    end
end
