"""
Binomial Matrix
===============
The matrix is a multiple of an involutory matrix.

# Input Options
- dim: the dimension of the matrix.

# References
**G. Boyd, C. A. Micchelli, G. Strang and D. X. Zhou**,
Binomial matrices, Adv. Comput. Math., 14 (2001), pp. 379-391,
https://doi.org/10.1023/A:1012207124894.
"""
struct Binomial{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Binomial{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n)
    end
end

# constructors
Binomial(n::Integer) = Binomial{Int}(n)

# metadata
@properties Binomial [:involutory, :integer]

# properties
size(A::Binomial) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Binomial{T}, k::Integer, j::Integer) where {T}
    n = A.n - 1
    k = k - 1
    j = j - 1
    element = sum([binomial(k, i) * (-1)^i * binomial(n - k, j - i) for i = max(0, j + k - n):min(j, k)])
    return T(element)
end
