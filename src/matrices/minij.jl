"""
MIN[I,J] Matrix
===============
A matrix with `(i,j)` entry `min(i,j)`. It is a symmetric positive
     definite matrix. The eigenvalues and eigenvectors are known
     explicitly. Its inverse is tridiagonal.

*Input options:*

+ [type,] dim: the dimension of the matrix.

*Groups:* ["inverse", "symmetric", "posdef", "eigen"]

*References:*

**J. Fortiana and C. M. Cuadras**, A family of matrices,
            the discretized Brownian bridge, and distance-based regression,
            Linear Algebra Appl., 264 (1997), 173-188.  (For the eigensystem of A.)
"""
struct Minij{T<:Integer} <: AbstractMatrix{T}
    n::Int

    function Minij(::Type{T}, n::Int) where {T<:Integer}
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(n)
    end
end

# constructors
Minij(n::Int) = Minij(Int, n)

# metadata
@properties Minij [:symmetric, :inverse, :posdef, :eigen]

# properties
size(s::Minij) = (s.n, s.n)
LinearAlgebra.isdiag(::Minij) = false
LinearAlgebra.ishermitian(::Minij) = true
LinearAlgebra.isposdef(::Minij) = true
LinearAlgebra.issymmetric(::Minij) = true
LinearAlgebra.adjoint(A::Minij) = A
LinearAlgebra.transpose(A::Minij) = A

# functions
@inline Base.Base.@propagate_inbounds function getindex(A::Minij{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(min(i, j))
end

function LinearAlgebra.inv(A::Minij{T}) where {T}
    if A.n == 1
        return ones(T, 1, 1)
    else
        return SymTridiagonal(2 * ones(T, A.n), -ones(T, A.n - 1))
    end
end
