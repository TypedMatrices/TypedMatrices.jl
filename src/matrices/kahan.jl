"""
Kahan Matrix
============
The Kahan matrix is an upper trapezoidal matrix, i.e., the
`(i,j)` element is equal to `0` if `i > j`. The useful range of
    `θ` is `0 < θ < π`. The diagonal is perturbed by
    `pert*eps()*diagm([n:-1:1;])`.

# Input Options
- rowdim, coldim, θ, pert: `rowdim` and `coldim` are the row and column
    dimensions of the matrix. `θ` and `pert` are scalars.
- dim, θ, pert: `dim` is the dimension of the matrix.
- dim: `θ = 1.2`, `pert = 25`.

# References
**W. Kahan**, Numerical linear algebra, Canadian Math. Bulletin,
9 (1966), pp. 757-801, https://doi.org/10.4153/CMB-1966-083-2.
"""
struct Kahan{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    theta::T
    pert::T

    function Kahan{T}(m::Integer, n::Integer, theta::T, pert::T) where {T<:Number}
        m >= 0 || throw(ArgumentError("$m < 0"))
        n >= 0 || throw(ArgumentError("$n < 0"))
        zero(T) < theta < pi || throw(ArgumentError("$theta ≤ 0 or $theta ≥ π"))
        pert > zero(T) || throw(ArgumentError("$pert ≤ 0"))
        return new{T}(m, n, theta, pert)
    end
end

# constructors
Kahan(n::Integer) = Kahan{Float64}(n, n)
Kahan(m::Integer, n::Integer) = Kahan{Float64}(m, n)
Kahan(n::Integer, theta::Number, pert::Number) = Kahan{Float64}(n, n, theta, pert)
Kahan{T}(n::Integer) where {T<:Number} = Kahan{T}(n, n)
Kahan{T}(m::Integer, n::Integer) where {T<:Number} = Kahan{T}(m, n, T(1.2), T(25.0))
Kahan{T}(n::Integer, theta::Number, pert::Number) where {T<:Number} = Kahan{T}(n, n, theta, pert)
function Kahan(m::Integer, n::Integer, theta::AbstractFloat, pert::AbstractFloat)
    Ta = typeof(theta)
    Tp = typeof(pert)
    T = promote_type(Ta, Tp)
    return Kahan{T}(m, n, convert(T, theta), convert(T, pert))
end

# metadata
@properties Kahan [:rectangular, :triangular, :inverse, :illcond]

# properties
size(A::Kahan) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Kahan{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    m = min(A.m, A.n)
    s = sin(A.theta)
    c = cos(A.theta)
    if i > m
        return zero(T)
    elseif i > j
        return zero(T)
    elseif i == j
        return s^(i - 1) + A.pert * eps(T) * (m - i + 1)
    else
        return -c * s^(i - 1)
    end
end
