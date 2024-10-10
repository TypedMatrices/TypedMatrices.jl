"""
Circulant Matrix
================
A circulant matrix has the property that each row is obtained
by cyclically permuting the entries of the previous row one
step forward.

# Input Options
- vec: a vector.
- dim: an integer, as vector `1:dim`.

# References
**P. J. Davis**, Circulant Matrices, John Wiley, 1977.
"""
struct Circulant{T<:Number} <: AbstractMatrix{T}
    n::Integer
    v::AbstractVector{T}

    function Circulant(v::AbstractVector{T}) where {T<:Number}
        return new{T}(length(v), v)
    end
end

# constructors
Circulant(n::Integer) = Circulant{Int}(n)
Circulant{T}(n::Integer) where {T<:Number} = Circulant(T[1:n;])

# metadata
@properties Circulant [:circulant, :toeplitz, :normal, :eigen]

# properties
size(A::Circulant) = (A.n, A.n)
LinearAlgebra.isdiag(A::Circulant) = A.n <= 1 ? true : false
LinearAlgebra.ishermitian(A::Circulant) = A.n <= 2 ? true : false
LinearAlgebra.isposdef(A::Circulant) = A.n <= 1 ? true : false
LinearAlgebra.issymmetric(A::Circulant) = A.n <= 2 ? true : false

# functions
@inline Base.@propagate_inbounds function getindex(A::Circulant{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.v[1+mod(j - i, A.n)]
end
