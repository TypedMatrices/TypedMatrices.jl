"""
Comparison Matrix
=================
The comparison matrix of a given matrix.

# Input Options
- B, k: `B` is a matrix.
    If `k = 0`, then `C(i,j) = abs(B(i,j))` for `i ≠ j` and `C(i,i) = -abs(B(i,i))`.
    If `k = 1`, then `C(i,i) = abs(B(i,i))` and `C(i,j) = -max(abs(B(i,:)))` for `i ≠ j`.
- B: `B` is a matrix and `k = 1`.

**N. J. Higham**, Efficient algorithms for computing the condition number
of a tridiagonal matrix, SIAM J. Sci. Stat. Comput., 7 (1986), pp. 150-165,
https://doi.org/10.1137/0907011.
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

# metadata
@properties Comparison Property[]

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
