"""
Oscillating Matrix
==================
A matrix `A` is called oscillating if `A` is totally
    nonnegative and if there exists an integer `q > 0` such that
    `A^q` is totally positive.

# Input Options
- Σ: the singular value spectrum of the matrix.
- dim, mode: `dim` is the dimension of the matrix.
        `mode = 1`: geometrically distributed singular values.
        `mode = 2`: arithmetrically distributed singular values.
- dim: `mode = 1`.

# References
**P. C. Hansen**, Test matrices for regularization methods, SIAM J.
Sci. Comput., 16 (1995), pp. 506-512, https://doi.org/10.1137/0916032.
.
"""
struct Oscillate{T<:Number} <: AbstractMatrix{T}
    n::Integer
    Σ::Vector{T}
    M::Matrix{T}

    function Oscillate{T}(Σ::Vector{T}) where {T<:Number}
        n = length(Σ)
        dv = rand(T, 1, n)[:] .+ eps(T)
        ev = rand(T, 1, n - 1)[:] .+ eps(T)
        B = Bidiagonal(dv, ev, :U)
        U, S, V = svd(B)
        M = U * Diagonal(Σ) * U'
        return new{T}(n, Σ, M)
    end
end

# constructors
Oscillate(Σ::Vector{T}) where {T<:Number} = Oscillate{T}(Σ)
Oscillate(n::Integer) = Oscillate(n, 2)
Oscillate(n::Integer, mode::Integer) = Oscillate{Float64}(n, mode)
Oscillate{T}(n::Integer) where {T<:Number} = Oscillate{T}(n, 2)
function Oscillate{T}(n::Integer, mode::Integer) where {T<:Number}
    n >= 0 || throw(ArgumentError("$n < 0"))
    mode ∈ 1:2 || throw(ArgumentError("mode must be 1 or 2"))

    κ = sqrt(1 / eps(T))
    if mode == 1
        factor = κ^(-1 / (n - 1))
        Σ = factor .^ [0:n-1;]
    elseif mode == 2
        Σ = ones(T, n) - T[0:n-1;] / (n - 1) * (1 - 1 / κ)
    end

    return Oscillate{T}(Σ)
end

# metadata
@properties Oscillate [:illcond, :eigen, :random]

# properties
size(A::Oscillate) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Oscillate{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
