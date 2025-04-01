"""
Grcar Matrix
============
The Grcar matrix is a Toeplitz matrix with sensitive
eigenvalues.

# Input Options
- dim, k: `dim` is the dimension of the matrix and
    `k` is the number of superdiagonals.
- dim: the dimension of the matrix.

# References
**J. F. Grcar**, Operator coefficient methods for linear equations,
Report SAND89-8691, Sandia National Laboratories, Albuquerque,
New Mexico, 1989 (Appendix 2).
"""
struct Grcar{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer

    function Grcar{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k >= 0 || throw(ArgumentError("$k < 0"))
        return new{T}(n, k)
    end
end

# constructors
Grcar(n::Integer) = Grcar(n, 3)
Grcar(n::Integer, k::Integer) = Grcar{Int}(n, k)
Grcar{T}(n::Integer) where {T<:Number} = Grcar{T}(n, 3)

# metadata
@properties Grcar [:eigen, :hessenberg, :integer, :toeplitz]

# properties
size(A::Grcar) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Grcar{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j + 1
        return -one(T)
    elseif j - A.k <= i <= j
        return one(T)
    else
        return zero(T)
    end
end
