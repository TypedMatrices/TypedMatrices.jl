"""
Binomial Matrix
===============
The matrix is a multiple of an involutory matrix.

*Input options:*

+ dim: the dimension of the matrix.
"""
struct Binomial{T<:Number} <: AbstractMatrix{T}
    n::Integer

    function Binomial{T}(n::Integer) where {T<:Number}
        n > 0 || throw(ArgumentError("$n ≤ 0"))
        return new{T}(n)
    end
end

# constructors
Binomial(n::Integer) = Binomial{Int}(n)

# properties
size(A::Binomial) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Binomial{T}, k::Integer, j::Integer) where {T}
    # TODO: implement getindex
    return one(T)

    # n = A.n

    # 2.6
    # return sum([binomial(k, i) * ((-1)^i) * binomial(n - k, j - i) for i = max(0, j + k - n):min(j, k)])

    # 2.1
    # function test(k, x, n, q=2)
    #     return sum([(-1)^j * (q - 1)^(k - j) * binomial(x, j) * binomial(n - x, k - j) for j = 0:k])
    # end
    # return test(k, j, n)
end
