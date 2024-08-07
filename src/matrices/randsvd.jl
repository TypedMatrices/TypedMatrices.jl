"""
Pre-multiply by random orthogonal matrix
"""
function qmult!(A::Matrix{T}) where {T}
    n, m = size(A)

    d = zeros(T, n)
    for k = n-1:-1:1

        # generate random Householder transformation
        x = randn(n - k + 1)
        s = norm(x)
        sgn = sign(x[1]) + (x[1] == 0)
        s = sgn * s
        d[k] = -sgn
        x[1] = x[1] + s
        beta = s * x[1]

        # apply the transformation to A
        y = x' * A[k:n, :]
        A[k:n, :] = A[k:n, :] - x * (y / beta)
    end

    # tidy up signs
    for i = 1:n-1
        A[i, :] = d[i] * A[i, :]
    end
    A[n, :] = A[n, :] * sign(randn())
    return A
end

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
Philadelphia, PA, USA, 2002; sec. 28.3.
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
RandSVD(n::Integer) = RandSVD(n, sqrt(1 / eps()))
RandSVD(n::Integer, kappa::Number) = RandSVD(n, kappa, 3)
RandSVD(n::Integer, kappa::Number, mode::Integer) = RandSVD(n, n, kappa, mode)
RandSVD(m::Integer, n::Integer, kappa::T, mode::Integer) where {T<:Number} = RandSVD{T}(m, n, kappa, mode)
RandSVD{T}(n::Integer) where {T<:Number} = RandSVD(n, sqrt(1 / eps(T)))
RandSVD{T}(n::Integer, kappa::T) where {T<:Number} = RandSVD{T}(n, kappa, 3)
RandSVD{T}(n::Integer, kappa::T, mode::Integer) where {T<:Number} = RandSVD{T}(n, n, kappa, mode)

# metadata
@properties RandSVD [:illcond, :random]

# properties
size(A::RandSVD) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::RandSVD{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end