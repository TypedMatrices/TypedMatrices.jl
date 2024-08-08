using Polynomials: Polynomial

"""
Companion Matrix
================
The companion matrix to a monic polynomial
    `a(x) = a_0 + a_1x + ... + a_{n-1}x^{n-1} + x^n`
    is the n-by-n matrix with ones on the subdiagonal and
    the last column given by the coefficients of `a(x)`.

# Input Options
- vec: `vec` is a vector of coefficients.
- dim: `vec = [1:dim;]`. `dim` is the dimension of the matrix.
- polynomial: `polynomial` is a polynomial. vector will be appropriate values from coefficients.
"""
struct Companion{T<:Number} <: AbstractMatrix{T}
    n::Integer
    v::AbstractVector{T}

    function Companion(v::AbstractVector{T}) where {T}
        return new{T}(length(v), v)
    end
end

# constructors
Companion(n::Integer) = Companion{Int}(n)
Companion(polynomial::Polynomial) = Companion{Float64}(polynomial)
Companion{T}(n::Integer) where {T<:Number} = Companion(T[1:n;])
Companion{T}(polynomial::Polynomial) where {T<:Number} = Companion(T.(-polynomial.coeffs[end-1:-1:begin] ./ polynomial.coeffs[end]))

# properties
size(A::Companion) = (A.n, A.n)
LinearAlgebra.isdiag(A::Companion) = A.n <= 1 ? true : false
LinearAlgebra.isposdef(A::Companion) = A.n <= 1 ? true : false

# functions
@inline Base.@propagate_inbounds function getindex(A::Companion{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == 1
        return A.v[j]
    elseif j == i - 1
        return one(T)
    else
        return zero(T)
    end
end
