"""
Dramadah Matrix
================
Dramadah matrix is a matrix with 0s and 1s.

# Input Options
- dim, k: the dimension of the matrix and k.
    `k = 1` abs(det(A)) = 1, the inverse has integer entries.
    `k = 2` the inverse has integer entries.
    `k = 3` det(A) is equal to nth Fibonacci number.
- dim: `k = 1`.
"""
struct Dramadah{T<:Number} <: AbstractMatrix{T}
    n::Integer
    k::Integer
    A::AbstractMatrix{T}

    function Dramadah{T}(n::Integer, k::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))
        k ∈ 1:3 || throw(ArgumentError("k must be in 1:3"))

        # generate matrix
        if k == 1
            c = ones(T, n)
            for i = 2:4:n
                m = min(1, n - i)
                c[i:i+m] .= 0
            end
            r = zeros(T, max(n, 4))
            r[1:4] = [1 1 0 1]
            if n < 4
                r = r[1:n]
            end
            A = Toeplitz(c, r)
        elseif k == 2
            c = zeros(T, n)
            c[1] = 1
            r = ones(T, n)
            r[3:2:n] .= 0
            A = Toeplitz(c, r)
        elseif k == 3
            c = ones(T, n)
            c[2:2:n] .= 0
            A = Toeplitz(c, T[1, 1, zeros(T, n - 2)...])
        end

        return new{T}(n, k, A)
    end
end

# constructors
Dramadah(n::Integer) = Dramadah(n, 1)
Dramadah(n::Integer, k::Integer) = Dramadah{Int}(n, k)
Dramadah{T}(n::Integer) where {T<:Number} = Dramadah{T}(n, 1)

# metadata
@properties Dramadah Symbol[]

# properties
size(A::Dramadah) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Dramadah{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.A[i, j]
end
