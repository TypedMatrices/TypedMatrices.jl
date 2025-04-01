"""
Jordan Block Matrix
===================
Jordan block corresponding to the eigenvalue λ.

# Input Options
- dim: dimension of the matrix. `lambda = 1`.
- dim, lambda: dimension of the matrix and the lambda.
"""
struct JordBloc{T<:Number} <: AbstractMatrix{T}
    n::Integer
    lambda::T

    function JordBloc{T}(n::Integer, lambda::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        return new{T}(n, lambda)
    end
end

# constructors
JordBloc(n::Integer) = JordBloc(n, 1)
JordBloc(n::Integer, lambda::Number) = JordBloc{Int}(n, lambda)
JordBloc{T}(n::Integer) where {T<:Number} = JordBloc{T}(n, T(1))

# metadata
@properties JordBloc [:bidiagonal, :binary, :defective, :eigen, :nonneg, :toeplitz]

# properties
size(A::JordBloc) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::JordBloc{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    if i == j
        return A.lambda
    elseif i == j - 1
        return one(T)
    else
        return zero(T)
    end
end
