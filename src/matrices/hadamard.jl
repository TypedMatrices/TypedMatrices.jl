"""
Hadamard Matrix
===============
The Hadamard matrix is a square matrix of order a power of 2,
whose entries are `1` or `–1`. It was named after Jacques
Hadamard. The rows of a Hadamard matrix are orthogonal.

# Input Options
- dim: the dimension of the matrix, `dim` is a power of 2.

# References
**S. W. Golomb and L. D. Baumert**, The search for Hadamard
matrices, Amer. Math. Monthly, 70 (1963) pp. 12-17,
https://doi.org/10.1080/00029890.1963.11990035.
"""
struct Hadamard{T<:Number} <: AbstractMatrix{T}
    n::Integer
    H::Matrix{T}

    function Hadamard{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        ispow2(n) || throw(ArgumentError("$n is not a power of 2"))

        # generate Hadamard matrix
        H = ones(T, 1, 1)
        for _ = 1:log2(n)
            H = [H H; H -H]
        end

        return new{T}(n, H)
    end
end

# constructors
Hadamard(n::Integer) = Hadamard{Int}(n)

# metadata
@properties Hadamard [:inverse, :integer, :fixedsize]

# properties
size(A::Hadamard) = (A.n, A.n)
LinearAlgebra.issymmetric(A::Hadamard) = true
LinearAlgebra.ishermitian(A::Hadamard) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Hadamard{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.H[i, j]
end
