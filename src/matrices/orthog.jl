"""
Orthogonal Matrix
=================
Orthogonal and nearly orthogonal matrices.

# Input Options
- dim: the dimension of the matrix. `k = 1` by default.
- dim, k: the dimension and type of the matrix.
"""
struct Orthog{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer
    M4::AbstractMatrix{T}

    function Orthog{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k ∈ -2:-1 || k ∈ 1:6 || throw(ArgumentError("$k not in -2:-1 or 1:6"))

        # k = 4 matrix
        M4 = zeros(T, 0, 0)
        if k == 4
            M4 = tril(ones(T, n, n))
            M4[1, 2:n] .= one(T)
            for i = 2:n
                M4[i, i] = -(i - 1)
            end
            M4 = diagm(sqrt.([[n]; 1:n-1] .* (1:n))) \ M4
        end

        return new{T}(n, k, M4)
    end
end

# constructors
Orthog(n::Integer) = Orthog(n, 1)
Orthog(n::Integer, k::Integer) = Orthog{Float64}(n, k)
Orthog{T}(n::Integer) where {T<:Number} = Orthog{T}(n, 1)

# metadata
@properties Orthog Symbol[:orthogonal]

# properties
size(A::Orthog) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Orthog{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    n = A.n
    k = A.k
    if k == -2
        return T(cos((i - 1) * (j - 1 / 2) * pi / n))
    elseif k == -1
        return T(cos((i - 1) * (j - 1) * pi / (n - 1)))
    elseif k == 1
        return T(sqrt(2 / (n + 1)) * sin(i * j * pi / (n + 1)))
    elseif k == 2
        return T(2 / (sqrt(2 * n + 1)) * sin(2 * i * j * pi / (2 * n + 1)))
    elseif k == 3
        return T(exp(2 * pi * im * (i - 1) * (j - 1) / n) / sqrt(n))
    elseif k == 4
        return A.M4[i, j]
    elseif k == 5
        return T(sin(2 * pi * (i - 1) * (j - 1) / n) / sqrt(n) + cos(2 * pi * (i - 1) * (j - 1) / n) / sqrt(n))
    elseif k == 6
        return T(sqrt(2 / n) * cos((i - 1 / 2) * (j - 1 / 2) * pi / n))
    end
end
