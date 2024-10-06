using SparseArrays: sparse

"""
Wathen Matrix
=============
The Wathen Matrix is the consistent mass matrix of a regular `nx`-by-`ny`` grid of
8 nodes in the finite element method. The matrix is a sparse, symmetric positive
definite, and has random entries.

# Input Options
- [type,] nx, ny: the dimension of the matrix is equal to
    `3 * nx * ny + 2 * nx * ny + 1`.
- [type,] n: `nx = ny = n`.

# References
**A. J. Wathen**, Realistic eigenvalue bounds for the Galerkin
mass matrix, IMA J. Numer. Anal., 7 (1987), pp. 449-457,
https://doi.org/10.1093/imanum/7.4.449.
"""
struct Wathen{T<:Number} <: AbstractMatrix{T}
    nx::Integer
    ny::Integer
    M::AbstractMatrix{T}

    function Wathen{T}(nx::Integer, ny::Integer) where {T<:Number}
        nx >= 0 || throw(ArgumentError("$nx < 0"))
        ny >= 0 || throw(ArgumentError("$ny < 0"))

        # create matrix
        e1 = T[6 -6 2 -8; -6 32 -6 20; 2 -6 6 -6; -8 20 -6 32]
        e2 = T[3 -8 2 -6; -8 16 -8 20; 2 -8 3 -8; -6 20 -8 16]
        e3 = [e1 e2; e2' e1] / 45
        n = 3 * nx * ny + 2 * nx + 2 * ny + 1
        ntriplets = nx * ny * 64
        Irow = zeros(Int, ntriplets)
        Jrow = zeros(Int, ntriplets)
        Xrow = zeros(T, ntriplets)
        ntriplets = 0
        rho = 100 * rand(nx, ny)
        node = zeros(T, 8)

        for j = 1:ny
            for i = 1:nx

                node[1] = 3 * j * nx + 2 * i + 2 * j + 1
                node[2] = node[1] - 1
                node[3] = node[2] - 1
                node[4] = (3 * j - 1) * nx + 2 * j + i - 1
                node[5] = (3 * j - 3) * nx + 2 * j + 2 * i - 3
                node[6] = node[5] + 1
                node[7] = node[5] + 2
                node[8] = node[4] + 1

                em = convert(T, rho[i, j]) * e3

                for krow = 1:8
                    for kcol = 1:8
                        ntriplets += 1
                        Irow[ntriplets] = node[krow]
                        Jrow[ntriplets] = node[kcol]
                        Xrow[ntriplets] = em[krow, kcol]
                    end
                end

            end
        end
        M = sparse(Irow, Jrow, Xrow, n, n)

        return new{T}(nx, ny, M)
    end
end

# constructors
Wathen(n::Integer) = Wathen(n, n)
Wathen(nx::Integer, ny::Integer) = Wathen{Float64}(nx, ny)
Wathen{T}(n::Integer) where {T<:Number} = Wathen{T}(n, n)

# metadata
@properties Wathen [:symmetric, :posdef, :eigen, :sparse, :random]

# properties
size(A::Wathen) = size(A.M)
LinearAlgebra.issymmetric(::Wathen) = true

# functions
@inline Base.@propagate_inbounds function getindex(A::Wathen{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
