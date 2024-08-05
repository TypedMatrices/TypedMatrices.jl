"""
Fiedler Matrix
==============
The Fiedler matrix is symmetric matrix with a dominant
      positive eigenvalue and all the other eigenvalues are negative.

# Input Options
- vec: a vector.
- dim: `dim` is the dimension of the matrix. `vec=[1:dim;]`.

# References
**G. Szego**, Solution to problem 3705, Amer. Math.
            Monthly, 43 (1936), pp. 246-259.

**J. Todd**, Basic Numerical Mathematics, Vol. 2: Numerical Algebra,
            Birkhauser, Basel, and Academic Press, New York, 1977, p. 159.
"""
struct Fiedler{T<:Number} <: AbstractMatrix{T}
    n::Integer
    vec::Vector{T}

    function Fiedler(vec::Vector{T}) where {T<:Number}
        return new{T}(length(vec), vec)
    end
end

# constructors
Fiedler(n::T) where {T<:Integer} = Fiedler(T[1:n;])

# metadata
@properties Fiedler [:inverse, :symmetric, :eigen]

# properties
size(A::Fiedler) = (A.n, A.n)
LinearAlgebra.issymmetric(::Fiedler) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Fiedler{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return abs(A.vec[i] - A.vec[j])
end
