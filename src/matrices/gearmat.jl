"""
Gear Matrix
===========
A gear matrix. 1's on the sub and super diagonal,
sign(i) on the (1,abs(i)) and sign(j) on the (n,n+1-abs(j)) position,
other elements are 0.

# Input Options
- dim: the dimension of the matrix. `i = n` and `j = -n` by default.
- dim, i, j: the dimension of the matrix and the position of the 1's.
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
@properties GearMat Symbol[:eigen, :rankdef, :integer]

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
