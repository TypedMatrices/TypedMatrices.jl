"""
Random Matrix with Pre-assigned Singular Values
===============================================
# Input Options
- row_dim, col_dim, kappa, mode: `row_dim` and `col_dim`
    are the row and column dimensions.
  `kappa` is the condition number of the matrix.
  `mode = 1`: one large singular value.
  `mode = 2`: one small singular value.
  `mode = 3`: geometrically distributed singular values.
  `mode = 4`: arithmetrically distributed singular values.
  `mode = 5`: random singular values with  unif. dist. logarithm.
- dim, kappa, mode: `row_dim = col_dim = dim`.
- dim, kappa: `mode = 3`.
- dim: `kappa = sqrt(1/eps())`, `mode = 3`.

# References
**N. J. Higham**, Accuracy and Stability of Numerical
Algorithms, second edition, Society for Industrial and Applied Mathematics,
Philadelphia, PA, USA, 2002. See sect. 28.3.
"""
struct RandSVD{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    kappa::T
    M::AbstractMatrix{T}

    function RandSVD{T}(m::Integer, n::Integer, kappa::T, mode::Integer) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        kappa >= 1 || throw(ArgumentError("Condition number must be at least 1."))
        mode ∈ 1:5 || throw(ArgumentError("mode not in 1:5"))

        # create matrix
        p = min(m, n)
        if p == 1 # handle 1-d case
            return ones(T, 1, 1) * kappa
        end

        if mode == 1
            sigma = ones(p) ./ kappa
            sigma[1] = one(T)
        elseif mode == 2
            sigma = ones(T, p)
            sigma[p] = one(T) / kappa
        elseif mode == 3
            factor = kappa^(-1 / (p - 1))
            sigma = factor .^ [0:p-1;]
        elseif mode == 4
            sigma = ones(T, p) - T[0:p-1;] / (p - 1) * (1 - 1 / kappa)
        elseif mode == 5
            sigma = exp.(-rand(p) * log(kappa))
        end

        M = zeros(T, m, n)
        M[1:p, 1:p] = diagm(0 => sigma)
        M = qmult!(copy(M'))
        M = qmult!(copy(M'))

        return new{T}(m, n, kappa, M)
    end
end

# constructors
RandSVD(n::Integer) = RandSVD(n, n, sqrt(1 / eps()), 3)
RandSVD(n::Integer, kappa::Number) = RandSVD(n, n, kappa, 3)
RandSVD(n::Integer, kappa::Number, mode::Integer) = RandSVD(n, n, kappa, mode)
RandSVD(m::Integer, n::Integer, kappa::T, mode::Integer) where {T<:Number} = RandSVD{T}(m, n, kappa, mode)
RandSVD{T}(n::Integer) where {T<:Number} = RandSVD(n, sqrt(1 / eps(T)))
RandSVD{T}(n::Integer, kappa::T) where {T<:Number} = RandSVD{T}(n, kappa, 3)
RandSVD{T}(n::Integer, kappa::T, mode::Integer) where {T<:Number} = RandSVD{T}(n, n, kappa, mode)

# metadata
@properties RandSVD [:illcond, :random, :illcond] Dict{Vector{Symbol}, Function}(
    [:illcond] => (n) -> RandSVD(n),
    [:rectangular] => (n) -> RandSVD(2 * n, n, sqrt(1 / eps()), 3)
)

# properties
size(A::RandSVD) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::RandSVD{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
