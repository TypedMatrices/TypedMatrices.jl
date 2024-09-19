"""
Sylvester's orthogonal matrix
See Rosser matrix References 2.

for a = d = 2, b = c = 1, P_block' * P_block = 10 * Identity
"""
P_block(::Type{T}, a, b, c, d) where {T<:Number} =
    reshape(T[a, b, c, d, b, -a, -d, c, c, d, -a, -b, d, -c, b, -a], 4, 4)

"""
Rosser Matrix
=============
The Rosser matrix’s eigenvalues are very close together
        so it is a challenging matrix for many eigenvalue algorithms.

# Input Options
- dim, a, b: `dim` is the dimension of the matrix.
            `dim` must be a power of 2.
            `a` and `b` are scalars. For `dim = 8, a = 2` and `b = 1`, the generated
            matrix is the test matrix used by Rosser.
- dim: `a = rand(1:5), b = rand(1:5)`.

# References
**J. B. Rosser, C. Lanczos, M. R. Hestenes, and W. Karush**,
Separation of close eigenvalues of a real symmetric matrix,
J. Research National Bureau Standards, 47 (1951), pp. 291-297.
"""
struct Rosser{T<:Number} <: AbstractMatrix{T}
    n::Integer
    a::T
    b::T
    M::AbstractMatrix{T}

    function Rosser{T}(n::Integer, a::T, b::T) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        if n < 1
            lgn = 0
        else
            lgn = round(Integer, log2(n))
            2^lgn != n && throw(ArgumentError("n must be positive integer and a power of 2."))
        end

        if n == 0
            A = Matrix{T}(undef, 0, 0)
        elseif n == 1
            A = 611 * ones(T, 1, 1)
        elseif n == 2
            #eigenvalues are 500, 510
            B = T[101 1; 1 101]
            P = T[2 1; 1 -2]
            A = P' * B * P
        elseif n == 4
            # eigenvalues are 0.1, 1019.9, 1020, 1020 for a = 2 and b = 1
            B = zeros(T, n, n)
            B[1, 1], B[1, 4], B[4, 1], B[4, 4] = 101, 1, 1, 101
            B[2, 2], B[2, 3], B[3, 2], B[3, 3] = 1, 10, 10, 101
            P = P_block(T, a, b, b, a)
            A = P' * B * P
        elseif n == 8
            # eigenvalues are 1020, 1020, 1000, 1000, 0.098, 0, -1020
            B = zeros(T, n, n)
            B[1, 1], B[6, 1], B[2, 2], B[8, 2] = 102, 1, 101, 1
            B[3, 3], B[7, 3] = 98, 14
            B[4, 4], B[5, 4], B[4, 5], B[5, 5] = 1, 10, 10, 101
            B[1, 6], B[6, 6], B[3, 7], B[7, 7], B[2, 8], B[8, 8] = 1, -102, 14, 2, 1, 101
            P = [P_block(T, a, b, b, a)' zeros(T, 4, 4); zeros(T, 4, 4) P_block(T, b, -b, -a, a)]
            A = P' * B * P
        else
            lgn = lgn - 2
            halfn = round(Integer, n / 2)
            # using Sylvester's method
            P = P_block(T, a, b, b, a)
            m = 4
            for i in 1:lgn
                P = [P zeros(T, m, m); zeros(T, m, m) P]
                m = m * 2
            end
            # mix 4 2-by-2 matrices (with close eigenvalues) into a large nxn matrix.
            B_list = T[102, 1, 1, -102, 101, 1, 1, 101, 1, 10, 10, 101, 98, 14, 14, 2]
            B = zeros(T, n, n)
            j, k = 1, 5
            for i in 1:(halfn+1)
                indexend = halfn - 1 + i
                list_start = k
                list_end = k + 3

                if list_start > 16 || list_end > 16
                    k = 1
                    list_start = 1
                    list_end = 4
                end
                B[j, j], B[j, indexend], B[indexend, j], B[indexend, indexend] = B_list[list_start:list_end]
                j = j + 1
                k = k + 4
            end
            A = P' * B * P
        end

        return new{T}(n, a, b, A)
    end
end

# constructors
Rosser(n::Integer) = Rosser(n, rand(1:5), rand(1:5))
Rosser{T}(n::Integer) where {T<:Number} = Rosser{T}(n, T(rand(1:5)), T(rand(1:5)))
Rosser{T}(n::Integer, a::Number, b::Number) where {T<:Number} = Rosser{T}(n, convert(T, a), convert(T, b))
function Rosser(n::Integer, a::Number, b::Number)
    Ta = typeof(a)
    Tb = typeof(b)
    T = promote_type(Ta, Tb)
    return Rosser{T}(n, convert(T, a), convert(T, b))
end

# metadata
@properties Rosser [:fixedsize, :symmetric, :indefinite, :integer, :rankdef, :illcond, :random]

# properties
size(A::Rosser) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Rosser{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
