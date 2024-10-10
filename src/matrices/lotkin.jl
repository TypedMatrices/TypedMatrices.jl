"""
Lotkin Matrix
=============
The Lotkin matrix is the Hilbert matrix with its first row
altered to all ones. It is ill conditioned and has many
negative eigenvalues of small magnitude.

# Input Options
- dim: `dim` is the dimension of the matrix.

# References
**M. Lotkin**, A set of test matrices, Math. Tables Aid Comput.,
9 (1955), pp. 153-161, https://doi.org/10.2307/2002051.
"""
struct Lotkin{T<:Number} <: AbstractMatrix{T}
    n::Integer
    hilbert::Hilbert{T}

    function Lotkin{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, Hilbert{T}(n))
    end
end

# constructors
Lotkin(n::Integer) = Lotkin{Int}(n)
Lotkin{T}(n::Integer) where {T<:Integer} = Lotkin{Rational{T}}(n)

# metadata
@properties Lotkin [:inverse, :illcond, :eigen]

# properties
size(A::Lotkin) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Lotkin{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == 1
        return T(1)
    else
        return A.hilbert[i, j]
    end
end
