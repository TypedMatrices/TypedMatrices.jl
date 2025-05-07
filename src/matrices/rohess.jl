"""
Random Orthogonal Upper Hessenberg Matrix
=========================================
The matrix is constructed via a product of Givens rotations.

# Input Options
- dim: the dimension of the matrix.

# References
**W. B. Gragg**, The QR algorithm for unitary Hessenberg matrices,
J. Comp. Appl. Math., 16 (1986), pp. 1-8,
https://doi.org/10.1016/0377-0427(86)90169-X.
"""
struct Rohess{T<:Number} <: AbstractMatrix{T}
    n::Integer
    M::AbstractMatrix{T}

    function Rohess{T}(n::Integer) where {T<:Number}
        n >= 0 || throw(ArgumentError("$n < 0"))

        # create matrix
        x = rand(n - 1) * 2 * pi
        M = Matrix{T}(I, n, n)
        M[n, n] = sign(randn())
        for i = n:-1:2
            theta = x[i-1]
            c = convert(T, cos(theta))
            s = convert(T, sin(theta))
            M[[i - 1; i], :] = [c * M[i-1, :][:]' + s * M[i, :][:]'; -s * M[i-1, :][:]' + c * M[i, :][:]']
        end

        return new{T}(n, M)
    end
end

# constructors
Rohess(n::Integer) = Rohess{Float64}(n)

# metadata
@properties Rohess [:inverse, :orthogonal, :random]

# properties
size(A::Rohess) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Rohess{T}, i::Integer, j::Integer) where {T}
    @boundscheck checkbounds(A, i, j)
    return A.M[i, j]
end
