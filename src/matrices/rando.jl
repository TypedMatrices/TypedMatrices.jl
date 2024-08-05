"""
Random Matrix with Element -1, 0, 1
===================================

# Input Options
- row_dim, col_dim, k: `row_dim` and `col_dim` are row and column dimensions,
   `k = 1`: entries are 0 or 1.
   `k = 2`: entries are -1 or 1.
   `k = 3`: entries are -1, 0 or 1.
- dim, k: `row_dim = col_dim = dim`.
- dim: `k = 1`.
"""
struct Rando{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    M::AbstractMatrix{T}

    function Rando{T}(m::Integer, n::Integer, k::Integer) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        k ∈ 1:3 || throw(ArgumentError("invalid k value."))

        # create matrix
        if k == 1
            M = floor.(rand(m, n) .+ 0.5)
        elseif k == 2
            M = 2 * floor.(rand(m, n) .+ 0.5) .- one(T)
        elseif k == 3
            M = round.(3 * rand(m, n) .- 1.5)
        end

        return new{T}(m, n, M)
    end
end

# constructors
Rando(n::Integer) = Rando(n, 1)
Rando(n::Integer, k::Integer) = Rando(n, n, k)
Rando(m::Integer, n::Integer, k::Integer) = Rando{Int}(m, n, k)
Rando{T}(n::Integer) where {T<:Number} = Rando{T}(n, 1)
Rando{T}(n::Integer, k::Integer) where {T<:Number} = Rando{T}(n, n, k)

# metadata
@properties Rando [:random]

# properties
size(A::Rando) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Rando{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
