"""
Dorr Matrix
============
The Dorr Matrix is a diagonally dominant, ill-conditioned,
tridiagonal sparse matrix.

# Input Options
- dim, theta: `dim` is the dimension of the matrix and
        `theta` is the parameter of the matrix.
- dim: `theta = 0.01`.

# References
**F. W. Dorr**, An example of ill-conditioning in the numerical solution
of singular perturbation problems, Math. Comp., 25 (1971), pp. 271-283,
https://doi.org/10.1090/S0025-5718-1971-0297142-0.
"""
abstract type Dorr{T<:Number} <: AbstractMatrix{T} end

# constructors
Dorr(n::Integer) = Dorr(n, 0.01)
Dorr(n::Integer, theta::T) where {T<:Number} = Dorr{T}(n, theta)
Dorr{T}(n::Integer) where {T<:Number} = Dorr{T}(n, T(0.01))
function Dorr{T}(n::Integer, theta::T) where {T<:Number}
    n >= 0 || throw(ArgumentError("$n < 0"))

    c = zeros(T, n)
    e = zeros(T, n)
    d = zeros(T, n)

    h = 1 / (n + 1)
    m = floor(Int, (n + 1) / 2)
    term = theta / h^2

    for i = 1:m
        c[i] = -term * one(T)
        e[i] = c[i] - (0.5 - i * h) / h
        d[i] = -(c[i] + e[i])
    end

    for i = m+1:n
        e[i] = -term * one(T)
        c[i] = e[i] + (0.5 - i * h) / h
        d[i] = -(c[i] + e[i])
    end

    c = c[2:n]
    e = e[1:n-1]

    return Tridiagonal{T}(c, d, e)
end

# metadata
@properties Dorr [:diagdom, :illcond, :sparse, :tridiagonal]
