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
abstract type Clement{T<:Number} <: AbstractMatrix{T} end

# constructors
Clement(n::Integer) = Clement(n, 0)
Clement(n::Integer, k::Integer) = Clement{Float64}(n, k)
Clement{T}(n::Integer) where {T<:Number} = Clement{T}(n, 0)
function Clement{T}(n::Integer, k::Integer) where {T}
    # 1x1 case
    if n == 1
        return zeros(T, 1, 1)
    end

    # create the matrix
    n = n - 1
    x = T[n:-1:1;]
    z = T[1:n;]
    if k == 0
        return Tridiagonal(x, zeros(T, n + 1), z)
    else
        y = sqrt.(x .* z)
        return SymTridiagonal(zeros(T, n + 1), y)
    end
end

# metadata
@properties Clement [:tridiagonal, :eigen, :singval]
