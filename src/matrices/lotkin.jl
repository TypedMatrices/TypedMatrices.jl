"""
Lotkin Matrix
=============
The Lotkin matrix is the Hilbert matrix with its first row
        altered to all ones. It is unsymmetric, illcond and
        has many negative eigenvalues of small magnitude.

*Input options:*

+ dim: `dim` is the dimension of the matrix.

*References:*

**M. Lotkin**, A set of test matrices, MTAC, 9 (1955), pp. 153-161.
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
