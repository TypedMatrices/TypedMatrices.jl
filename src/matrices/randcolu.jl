
struct Randcolu{T<:Number} <: AbstractMatrix{T}
    m::Integer
    n::Integer
    x::Vector{T}
    k::Integer
    M::AbstractMatrix{T}

    function Randcolu(x::Vector{T}, m::Integer, k::Integer) where {T<:Number}
        n = length(x)
        n > 0 || throw(ArgumentError("$n <= 0"))
        m >= 0 || throw(ArgumentError("$m < 0"))
        m >= n || throw(ArgumentError("$m < $n"))
        abs(sum(x .^ 2) - n) / n <= 100 * eps(T) || all(x >= 0) || throw(ArgumentError("Invalid x"))

        # generate matrix
        A = zeros(T, m, n)
        for i = 1:n
            A[i, i] = x[i]
        end

        if k == 0
            A = qmult!(copy(A))
            A = qmult!(copy(A'))'
        end

        a = sum(A .* A, dims=1)
        a = reshape(a, n)

        y = findall(a .< 1)
        z = findall(a .> 1)

        while !isempty(y) && !isempty(z)
            i = rand(y)
            j = rand(z)
            if i > j
                i, j = j, i
            end

            aij = A[:, i]' * A[:, j]
            alpha = sqrt(aij^2 - (a[i] - 1) * (a[j] - 1))

            temp_t = (aij + newsign(aij) * alpha) / (a[j] - 1)
            t = rand([
                temp_t,
                (a[i] - 1) / ((a[j] - 1) * temp_t),
            ])
            c = 1 / sqrt(1 + t^2)
            s = t * c

            A[:, [i, j]] = A[:, [i, j]] * [c s; -s c]

            a[j] = a[j] + a[i] - 1
            a[i] = 1

            y = findall(a .< 1)
            z = findall(a .> 1)
        end

        return new{T}(m, n, x, k, A)
    end
end

# constructors
Randcolu(n::Integer) = Randcolu(n, n)
Randcolu(n::Integer, m::Integer) = Randcolu(n, m, 0)
Randcolu(n::Integer, m::Integer, k::Integer) = Randcolu{Float64}(n, m, k)
Randcolu(x::Vector) = Randcolu(x, length(x))
Randcolu(x::Vector, m::Integer) = Randcolu(x, m, 0)
Randcolu{T}(n::Integer) where {T<:Number} = Randcolu{T}(n, n)
Randcolu{T}(n::Integer, m::Integer) where {T<:Number} = Randcolu{T}(n, m, 0)
function Randcolu{T}(n::Integer, m::Integer, k::Integer) where {T<:Number}
    x = rand(T, n)
    x = sqrt(T(n)) * x / norm(x)
    return Randcolu(x, m, k)
end

# metadata
@properties Randcolu [:random]

# properties
size(A::Randcolu) = (A.m, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Randcolu{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
