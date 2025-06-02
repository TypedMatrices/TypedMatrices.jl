"""
Random Correlation Matrix
=========================
A random correlation matrix is a symmetric positive
     semidefinite matrix with 1s on the diagonal.

# Input Options
- dim: the dimension of the matrix.
"""
struct Randcorr{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::AbstractMatrix{T}

    function Randcorr{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        x = rand(T, n) # x is the vector of random eigenvalues from a uniform distribution.
        x = n * x / sum(x) # x has nonnegtive elements.
        F = qr(randn(T, n, n))
        Q = F.Q .* sign.(diag(F.R))' # form a random orthogonal matrix.
        A = Q * (x .* Q')

        a = diag(A)
        l = findall(a .< 1)
        g = findall(a .> 1)

        # Apply Given rotation to set A[i,i] = 1
        while length(l) > 0 && length(g) > 0
            k = ceil(Integer, rand() * length(l))
            h = ceil(Integer, rand() * length(g))
            i = l[k]
            j = g[h]
            if i > j
                i, j = j, i
            end
            alpha = sqrt(A[i, j]^2 - (a[i] - 1) * (a[j] - 1))
            # take sign to avoid cancellation.
            t = (A[i, j] + newsign(A[i, j]) * alpha) / (a[j] - 1)
            c = 1 / sqrt(1 + t^2)
            s = t * c

            A[:, [i, j]] = A[:, [i, j]] * [c s; -s c]
            A[[i, j], :] = [c -s; s c] * A[[i, j], :]

            A[i, i] = one(T)
            a = diag(A)
            l = findall(a .< 1)
            g = findall(a .> 1)
        end
        [A[i, i] = 1 for i = 1:n]
        A = (A + A') / 2

        return new{T}(n, A)
    end
end

# constructors
Randcorr(n::Integer) = Randcorr{Float64}(n)

# metadata
@properties Randcorr [:correlation, :random]

# properties
size(A::Randcorr) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Randcorr{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
