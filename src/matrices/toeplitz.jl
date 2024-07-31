"""
Toeplitz Matrix
===============
A Toeplitz matrix is a matrix in which each descending
       diagonal from left to right is constant.

*Input options:*

+ vc, vr: `vc` and `vr` are the first column and row of the matrix.

+ v: symmatric case, i.e., `vc = vr = v`.

+ dim: `dim` is the dimension of the matrix. `v = [1:dim;]` is the first
        row and column vector.
"""
struct Toeplitz{T<:Number} <: AbstractMatrix{T}
    n::Integer
    vc::Vector{T}
    vr::Vector{T}

    function Toeplitz{T}(vc::AbstractVector{T}, vr::AbstractVector{T}) where {T}
        n = length(vr)
        n == length(vc) || throw(DimensionMismatch("length of vc and vr must be equal"))
        vc[1] == vr[1] || throw(ArgumentError("first element of vc must be equal to first element of vr"))
        return new{T}(n, vc, vr)
    end
end

# constructors
Toeplitz(v::AbstractVector) = Toeplitz(v, v)
Toeplitz(n::T) where {T<:Integer} = Toeplitz(T[1:n;])
Toeplitz(vc::AbstractVector{T}, vr::AbstractVector{T}) where {T<:Number} = Toeplitz{T}(vc, vr)
Toeplitz{T}(v::AbstractVector) where {T<:Number} = Toeplitz{T}(v, v)
Toeplitz{T}(n::Integer) where {T<:Number} = Toeplitz(T[1:n;])

# properties
size(A::Toeplitz) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Toeplitz{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return i >= j ? A.vc[i-j+1] : A.vr[j-i+1]
end
