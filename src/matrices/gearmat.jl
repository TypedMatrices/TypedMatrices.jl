"""
Gear Matrix
===========
The Gear matrix has ones on the first subdiagonal and superdiagonal, and
has two additional entries of value ±1. Given the two integers
`-n ≤ i ≤ n` and `-n ≤ j ≤ n`, the matrix has the elements 
`sign(i)` in position `(1, abs(i))` and `sign(j)` in position `(n, n+1-abs(j))`.
The other elements are zeros.

# Input Options
- dim, i, j: the dimension of the matrix and the position of the 1s.
- dim: the dimension of the matrix. `i = n` and `j = -n` by default.

# References
**C. W. Gear**, A simple set of test matrices for eigenvalue programs,
Math. Comp., 23 (1969), pp. 119-125,
https://doi.org/10.1090/S0025-5718-1969-0238477-8.
"""
struct GearMat{T<:Number} <: AbstractMatrix{T}
    n::Integer
    i::Integer
    j::Integer

    function GearMat{T}(n::Integer, i::Integer, j::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        -n ≤ i ≤ n || throw(ArgumentError("i must be in -n:n"))
        -n ≤ j ≤ n || throw(ArgumentError("j must be in -n:n"))
        return new{T}(n, i, j)
    end
end

# constructors
GearMat(n::Integer) = GearMat(n, n, -n)
GearMat(n::Integer, i::Integer, j::Integer) = GearMat{Int}(n, i, j)
GearMat{T}(n::Integer) where {T<:Number} = GearMat{T}(n, n, -n)

# metadata
@properties GearMat [:defective, :eigen, :integer, :rankdef, :sparse]

# properties
size(A::GearMat) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::GearMat{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == 1 && j == abs(A.i)
        return T(sign(A.i))
    elseif i == A.n && j == A.n + 1 - abs(A.j)
        return T(sign(A.j))
    elseif i == j + 1 || i == j - 1
        return one(T)
    else
        return zero(T)
    end
end

# TODO: All eigenvalues are of the form 2*cos(a) and the eigenvectors are of the form [sin(w+a), sin(w+2a), …, sin(w+na)], where a and w are given in
# Gear, C. W. “A Simple Set of Test Matrices for Eigenvalue Programs.“ Mathematics of Computation 23, no. 105 (1969): 119-125.
