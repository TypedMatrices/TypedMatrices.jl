"""
Prolate Matrix
==============
A prolate matrix is a symmetirc, ill-conditioned Toeplitz matrix.

# Input Options
- dim, alpha: `dim` is the dimension of the matrix. `w` is a real scalar.
- dim: the case when `w = 0.25`.

# References
**J. M. Varah**. The Prolate Matrix. Linear Algebra and Appl.
             187:267--278, 1993.
"""
struct Prolate{T<:Number} <: AbstractMatrix{T}
    n::Integer
    w::T
    M::AbstractMatrix{T}

    function Prolate{T}(n::Integer, w::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        # generate vector
        v = Array{T,1}(undef, n)
        v[1] = 2 * w
        [v[i] = sin(2 * pi * w * i) / pi * i for i = 2:n]

        return new{T}(n, w, Toeplitz(v))
    end
end

# constructors
Prolate(n::Integer) = Prolate{Float64}(n, 0.25)
Prolate(n::Integer, w::T) where {T<:Number} = Prolate{T}(n, w)
Prolate{T}(n::Integer) where {T<:Number} = Prolate{T}(n, T(0.25))

# metadata
@properties Prolate [:symmetric, :illcond]

# properties
size(A::Prolate) = (A.n, A.n)
LinearAlgebra.issymmetric(::Prolate) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Prolate{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
