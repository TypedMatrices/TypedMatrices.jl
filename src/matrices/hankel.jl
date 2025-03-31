"""
Hankel Matrix
=============
A Hankel matrix is constant across the anti-diagonals. It is symmetric.

# Input Options
- vc, vr: `vc` and `vc` are the first column and last row of the
       matrix. If the last element of `vc` differs from the first element
                of `vr`, the last element of `rc` prevails.
- v: a vector, as `vc = v` and `vr` will be zeros.
- dim: `dim` is the dimension of the matrix. `v = [1:dim;]`.
"""
struct Hankel{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    p::Vector{T}

    function Hankel(vc::AbstractVector{T}, vr::AbstractVector{T}) where {T<:Number}
        lenc = length(vc)

        # if vr is empty
        lenr = length(vr)
        if (lenr == 0)
            vr = zeros(T, lenc)
        else
            vc[end] == vr[1] || throw(ArgumentError("last element of vc differs from first element of vr"))
        end

        return new{T}(lenc, length(vr), [vc; vr[2:end]])
    end
end

# constructors
Hankel(n::Integer) = Hankel{Int}(n)
Hankel{T}(n::Integer) where {T<:Number} = Hankel(T[1:n;])
Hankel(v::AbstractVector{T}) where {T<:Number} = Hankel(v, T[])

# metadata
@properties Hankel [:hankel]

# properties
size(A::Hankel) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Hankel{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.p[i+j-1]
end
