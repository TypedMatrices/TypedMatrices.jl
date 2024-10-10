"""
Matrix with Application in Sampling Theory
==========================================
A nonsymmetric matrix with eigenvalues 0, 1, 2, ... n-1.

# Input Options
- vec: `vec` is a vector with no repeated elements.
- dim: `dim` is the dimension of the matrix.
            `vec = [1:dim;]/dim`.

# References
**L. Bondesson and I. Traat**, A nonsymmetric matrix with integer
eigenvalues, Linear Multilinear Algebra, 55 (2007), pp. 239-247,
https://doi.org/10.1080/03081080600906455.
"""
struct Sampling{T<:Number} <: AbstractMatrix{T}
    n::Integer
    vec::Vector{T}

    function Sampling(vec::Vector{T}) where {T<:Number}
        n = length(vec)
        return new{T}(n, vec)
    end
end

# constructors
Sampling(n::Integer) = Sampling{Float64}(n)
Sampling{T}(n::Integer) where {T<:Number} = Sampling(T[1:n;] / n)

# metadata
@properties Sampling [:eigen]

# properties
size(A::Sampling) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Sampling{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if A.n == 1
        return zero(T)
    end

    if i == j
        element = sum([A[i, index] for index = 1:A.n if index != i])
    else
        element = A.vec[i] / (A.vec[i] - A.vec[j])
    end
    return element
end
