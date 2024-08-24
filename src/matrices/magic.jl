function oddmagic(::Type{T}, n::Integer) where {T<:Number}
    # compute the magic square of odd orders
    A = zeros(T, n, n)
    i = 1
    j = div(n + 1, 2)
    for k = 1:n^2
        is = i
        js = j
        A[i, j] = k
        i = n - rem(n + 1 - i, n)
        j = rem(j, n) + 1
        if A[i, j] != 0
            i = rem(is, n) + 1
            j = js
        end
    end
    return A
end

"""
Magic Square Matrix
===================
The magic matrix is a matrix with integer entries such that
    the row elements, column elements, diagonal elements and
    anti-diagonal elements all add up to the same number.

# Input Options
- dim: the dimension of the matrix.
"""
struct Magic{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::Matrix{T}

    function Magic{T}(n::Integer) where {T<:Number}
        n >= 3 || throw(ArgumentError("$n < 3"))

        # generate matrix
        if mod(n, 2) == 1
            # n is odd
            M = oddmagic(T, n)
        elseif mod(n, 4) == 0
            # n is doubly even
            a = floor.(Integer, mod.([1:n;], 4) / 2)
            B = broadcast(==, a', a)
            M = broadcast(+, T[1:n:n^2;]', T[0:n-1;])
            for i = 1:n, j = 1:n
                B[i, j] == 1 ? M[i, j] = n^2 + one(T) - M[i, j] : M[i, j]
            end
        else
            # n is singly even
            p = div(n, 2)
            M = oddmagic(T, p)
            M = [M M.+2*p^2; M.+3*p^2 M.+p^2]
            i = [1:p;]
            k = div(n - 2, 4)
            j = [[1:k;]; [(n-k+2):n;]]
            M[[i; i .+ p], j] = M[[i .+ p; i], j]
            i = k + 1
            j = [1, i]
            M[[i; i + p], j] = M[[i + p; i], j]
        end

        return new{T}(n, M)
    end
end

# constructors
Magic(n::Integer) = Magic{Int}(n)

# metadata
@properties Magic [:inverse]

# properties
size(A::Magic) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Magic{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
