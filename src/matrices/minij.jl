"""
MIN[I,J] Matrix
===============
A matrix with `(i,j)` entry `min(i,j)`. It is a symmetric positive
     definite matrix. The eigenvalues and eigenvectors are known
     explicitly. Its inverse is tridiagonal.

*Input options:*

+ dim: the dimension of the matrix.

*References:*

**J. Fortiana and C. M. Cuadras**, A family of matrices,
            the discretized Brownian bridge, and distance-based regression,
            Linear Algebra Appl., 264 (1997), 173-188.  (For the eigensystem of A.)
"""
struct Minij{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Minij{T}(n::Integer) where {T<:Number}
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(n)
    end
end

# constructors
Minij(n::Integer) = Minij{Int}(n)

# metadata
@properties Minij [:symmetric, :inverse, :posdef, :eigen]

# properties
size(A::Minij) = (A.n, A.n)
LinearAlgebra.isdiag(A::Minij) = A.n <= 1 ? true : false
LinearAlgebra.ishermitian(::Minij) = true
LinearAlgebra.isposdef(::Minij) = true
LinearAlgebra.issymmetric(::Minij) = true
LinearAlgebra.adjoint(A::Minij) = A
LinearAlgebra.transpose(A::Minij) = A

# functions
@inline Base.@propagate_inbounds function getindex(A::Minij{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return T(min(i, j))
end

function inv(A::Minij{T}) where {T}
    return SymTridiagonal([2 * ones(T, A.n - 1); 1], -ones(T, A.n - 1))
end

LinearAlgebra.eigvals(A::Minij) = [0.25 * sec(i * π / (2 * A.n + 1))^2 for i = 1:A.n]
