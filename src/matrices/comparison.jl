"""
Comparison Matrix
=================
The comparison matrix of a given matrix.

# Input Options
- B, k: `B` is a matrix.
    If `k = 0`, then `C(i,i) = abs(B(i,i))` and `C(i,i) = -abs(B(i,i))` for `i ≠ j`.
    If `k = 1`, then `C(i,i) = abs(B(i,i))` and `C(i,j) = -maximum(abs(B(i,[1:i-1,i+1:end])))` for `i ≠ j`.
- B: `B` is a matrix and `k = 1`.

**N. J. Higham**, Efficient algorithms for computing the condition number
of a tridiagonal matrix, SIAM J. Sci. Stat. Comput., 7 (1986), pp. 150-165,
https://doi.org/10.1137/0907011.
"""
struct Comparison{T<:Number} <: AbstractMatrix{T}
    M::AbstractMatrix{T}
    k::Integer

    function Comparison(A::AbstractMatrix{T}, k::Integer) where {T<:Number}
        k ∈ 0:1 || throw(ArgumentError("k must be 0 or 1."))
        if k == 0
            M = -abs.(A)
            M[diagind(M)] .= -M[diagind(M)]
        elseif k == 1
            M = -repeat([maximum(abs.(x[1:end .!= i])) for (i, x) in enumerate(eachrow(A))], 1, size(A, 2))
            M[diagind(M)] .= abs.(A[diagind(M)])
        end
        return new{T}(M, k)
    end
end

# constructors
Comparison(A::AbstractMatrix{T}) where {T<:Number} = Comparison(A, 0)
Comparison(n::Integer) = Comparison{Float64}(randn(n, n), 0)
Comparison{T}(A::AbstractMatrix{T}, k::Integer) where {T<:Number} = Comparison(A, k)

# metadata
@properties Comparison Property[]

# properties
size(A::Comparison) = size(A.M)

# functions
@inline Base.@propagate_inbounds function getindex(A::Comparison{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
