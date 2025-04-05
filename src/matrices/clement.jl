"""
Clement Matrix
==============
The Clement matrix is a tridiagonal matrix with zero
diagonal entries. If k = 1, the matrix is symmetric.

# Input Options
- dim, k: `dim` is the dimension of the matrix.
        If `k = 0`, the matrix is of type `Tridiagonal`.
        If `k = 1`, the matrix is of type `SymTridiagonal`.
- dim: `k = 0`.

# References
**P. A. Clement**, A class of triple-diagonal matrices
for test purposes, SIAM Rev., 1 (1959), pp. 50-52,
https://doi.org/10.1137/1001006.
"""
struct Clement{T<:Number} <: AbstractMatrix{T} 
    n::Integer
    M::AbstractMatrix{T}

    function Clement{T}(n::Integer, k::Integer) where {T}
        # 1x1 case
        if n == 1
            return zeros(T, 1, 1)
        end
    
        # create the matrix
        x = T[n-1:-1:1;]
        z = T[1:n-1;]
        if k == 0
            return new{T}(n, Tridiagonal(x, zeros(T, n), z))
        else
            y = sqrt.(x .* z)
            return new{T}(n, SymTridiagonal(zeros(T, n), y))
        end
    end    
end

# constructors
Clement(n::Integer) = Clement(n, 0)
Clement(n::Integer, k::Integer) = Clement{Float64}(n, k)
Clement{T}(n::Integer) where {T<:Number} = Clement{T}(n, 0)

# metadata
@properties Clement [:eigen, :nonneg, :singval, :tridiagonal] Dict{Vector{Symbol}, Function}(
     [:symmetric] => (n) -> Clement(n, 1),
)

# properties
size(A::Clement) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Clement{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end