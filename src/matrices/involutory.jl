"""
Involutory Matrix
=================
An involutory matrix is a matrix that is its own inverse.

# Input Options
- dim: `dim` is the dimension of the matrix.

# References
**A. S. Householder and J. A. Carpenter**, The singular values
of involutory and of idempotent matrices, Numer. Math. 5 (1963),
pp. 234-237, https://doi.org/10.1007/BF01385894.
"""
struct Involutory{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::AbstractMatrix{T}

    function Involutory{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, Hilbert{T}(n))
    end
end

# constructors
Involutory(n::Integer) = Involutory{Int}(n)
Involutory{T}(n::Integer) where {T<:Integer} = Involutory{Rational{T}}(n)

# metadata
@properties Involutory [:involutory, :integer, :illcond, :eigen]

# properties
size(A::Involutory) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Involutory{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)

    # size and hilbert element
    n = T(A.n)
    element = A.M[i, j]

    # compute element
    d = -n
    if j == 1
        element = d * element
    end

    # update element if i > 1
    if i > 1
        for k = 1:i-1
            d = -(n + k) * (n - k) * d / (k * k)
        end

        element = T(d) * element
    end

    # return
    return element
end
