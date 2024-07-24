"""
Companion Matrix
================
The companion matrix to a monic polynomial
    `a(x) = a_0 + a_1x + ... + a_{n-1}x^{n-1} + x^n`
    is the n-by-n matrix with ones on the subdiagonal and
    the last column given by the coefficients of `a(x)`.

*Input options:*

+ vec: `vec` is a vector of coefficients.

+ dim: `vec = [1:dim;]`. `dim` is the dimension of the matrix.
"""
struct Companion{T<:Number} <: AbstractMatrix{T}
    n::Integer
    v::AbstractVector{T}

    function Companion(v::AbstractVector{T}) where {T}
        return new{T}(length(v), v)
    end
end

# constructors
Companion(n::T) where {T<:Integer} = Companion(T[1:n;])

# properties
size(A::Companion) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Companion{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if j == A.n
        return A.v[i]
    elseif j == i - 1
        return one(T)
    else
        return zero(T)
    end
end
