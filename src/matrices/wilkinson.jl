"""
Wilkinson Matrix
================
The Wilkinson matrix is a symmetric tridiagonal matrix with pairs
of nearly equal eigenvalues. The most frequently used ordre is 21.

# Input Options
- dim: the dimension of the matrix.

# References
**J. H. Wilkinson**, Error analysis of direct methods of matrix
inversion, J. Assoc. Comput. Mach., 8 (1961), pp. 281-330,
https://doi.org/10.1145/321075.321076.
"""
struct Wilkinson{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Wilkinson{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Wilkinson(n::Integer) = Wilkinson{Float64}(n)

# metadata
@properties Wilkinson [:eigen, :symmetric, :sparse, :tridiagonal]

# properties
size(A::Wilkinson) = (A.n, A.n)
LinearAlgebra.isdiag(A::Wilkinson) = A.n <= 1 ? true : false
LinearAlgebra.issymmetric(::Wilkinson) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Wilkinson{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    n = A.n
    if n == 1
        return one(T)
    elseif i == j
        m = (n - 1) / 2
        return T(abs(m - (i - 1)))
    elseif i == j + 1 || i == j - 1
        return one(T)
    else
        return zero(T)
    end
end

function Base.replace_in_print_matrix(A::Wilkinson, i::Integer, j::Integer, s::AbstractString)
    i == j - 1 || i == j || i == j + 1 ? s : Base.replace_with_centered_mark(s)
end
