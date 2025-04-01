"""
Fiedler Matrix
==============
The Fiedler matrix has exactly one positive eigenvalue, the dominant one.
All the other eigenvalues are negative.

# Input Options
- vec: a vector.
- dim: `dim` is the dimension of the matrix. `vec=[1:dim;]`.

# References
**A. C. Schaeffer and G. Szegö**, Solution to problem 3705, Amer. Math. Monthly,
43 (1936), pp. 246-259, https://doi.org/10.1090/S0002-9947-1941-0005164-7.

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
Fiedler(n::Integer) = Fiedler{Int}(n)
Fiedler{T}(n::Integer) where {T<:Number} = Fiedler(T[1:n;])

# metadata
@properties Fiedler [:eigen, :indefinite, :inverse, :symmetric]

# properties
size(A::Fiedler) = (A.n, A.n)
LinearAlgebra.issymmetric(::Fiedler) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Fiedler{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return abs(A.vec[i] - A.vec[j])
end
