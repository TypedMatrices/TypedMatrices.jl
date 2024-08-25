"""
newsign: newsign(0) = 1
"""
function newsign(x)
    return x == 0 ? 1 : sign(x)
end

"""
Pre-multiply by random orthogonal matrix
"""
function qmult!(A::Matrix{T}) where {T<:Number}
    n, m = size(A)

    d = zeros(T, n)
    for k = n-1:-1:1

        # generate random Householder transformation
        x = randn(n - k + 1)
        s = norm(x)
        sgn = sign(x[1]) + (x[1] == 0)
        s = sgn * s
        d[k] = -sgn
        x[1] = x[1] + s
        beta = s * x[1]

        # apply the transformation to A
        y = x' * A[k:n, :]
        A[k:n, :] = A[k:n, :] - x * (y / beta)
    end

    # tidy up signs
    for i = 1:n-1
        A[i, :] = d[i] * A[i, :]
    end
    A[n, :] = A[n, :] * sign(randn())
    return A
end
