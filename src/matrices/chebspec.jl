"""
Chebyshev Spectral Differentiation Matrix
=========================================
If `k = 0`,the generated matrix is nilpotent and a vector with
        all one entries is a null vector. If `k = 1`, the generated
        matrix is nonsingular and well-conditioned. Its eigenvalues
        have negative real parts.

# Input Options
- dim, k: `dim` is the dimension of the matrix and
        `k = 0 or 1`.
- dim: `k=0`.

# References
**L. N. Trefethen and M. R. Trummer**, An instability
        phenomenon in spectral methods, SIAM J. Numer. Anal., 24 (1987), pp. 1008-1023.
"""
struct ChebSpec{T<:Number} <: AbstractMatrix{T}
    n::Int
    k::Int
    c::Vector{T}
    x::Vector{T}

    function ChebSpec{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k == 0 || k == 1 || throw(ArgumentError("k should be 0 or 1"))

        kn = k == 0 ? n : n + 1

        # c
        c = ones(T, kn)
        c[1] = 2
        c[2:kn-1] .= 1
        c[kn] = 2

        # chebyshev points
        x = ones(T, kn)
        for i = 1:kn
            x[i] = cos(pi * (i - 1) / (kn - 1))
        end

        return new{T}(n, k, c, x)
    end
end

# constructors
ChebSpec(n::Integer) = ChebSpec(n, 0)
ChebSpec(n::Integer, k::Integer) = ChebSpec{Float64}(n, k)

# metadata
@properties ChebSpec [:eigen]

# properties
size(A::ChebSpec) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::ChebSpec{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if A.k == 1
        i = i + 1
        j = j + 1
    end
    kn = A.k == 0 ? A.n : A.n + 1
    c = A.c
    x = A.x
    element = i != j ? (-1)^(i + j) * c[i] / (c[j] * (x[i] - x[j])) :
              i == 1 ? (2 * (kn - 1)^2 + 1) / 6 :
              i == kn ? -(2 * (kn - 1)^2 + 1) / 6 :
              -0.5 * x[i] / (1 - x[i]^2)
    return T(element)
end
