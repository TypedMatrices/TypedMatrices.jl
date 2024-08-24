"""
Comparison Matrix
=================
The comparison matrix for another matrix.

# Input Options
- B, k: `B` is a matrix.
    `k = 0`: each element is absolute value of `B`, except each diagonal element is negative absolute value.
    `k = 1`: each diagonal element is absolute value of `B`, except each off-diagonal element is negative largest absolute value in the same row.
- B: `B` is a matrix and `k = 1`.
"""
struct Comparison{T<:Number} <: AbstractMatrix{T}
    A::AbstractMatrix{T}
    k::Integer

    function Comparison(A::AbstractMatrix{T}, k::Integer) where {T<:Number}
        k ∈ 0:1 || throw(ArgumentError("k must be 0 or 1."))
        return new{T}(A, k)
    end
end

# constructors
Comparison(A::AbstractMatrix{T}) where {T<:Number} = Comparison(A, 0)

# properties
size(A::Comparison) = size(A.A)

# functions
@inline Base.@propagate_inbounds function getindex(A::Comparison{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    k = A.k
    if k == 0 && i == j
        return abs(A.A[i, j])
    elseif k == 0 && i != j
        return -abs(A.A[i, j])
    elseif k == 1 && i == j
        return abs(A.A[i, j])
    elseif k == 1 && i != j
        return -maximum(abs.(A.A[i, :][1:end.!=i]))
    end
end
