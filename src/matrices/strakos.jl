"""
Strakos Matrix
===============
The Strakos matrix is used to study CG and Lanczos algorithm convergence. 

# Input Options
- dim: the dimension of the matrix.
- p: controls eigenvalue distribution, typically 0.2<p<1 for clustering near λ1.
- λ1: smallest eigenvalue, typically 1e-2 or 1e-3.
- λn: largest eigenvalue, typically 1e2 or 1e3. 

# References
**Z. Strakoš,**
On the real convergence rate of the conjugate gradient method, 
Linear Algebra and its Applications, 154-156 (1991), pp. 535-549,
https://doi.org/10.1016/0024-3795(91)90393-B.
"""
struct Strakos{T<:Real} <: AbstractMatrix{T}
    n::Integer
    p::T
    λ1::T
    λn::T

    function Strakos{T}(n::Integer, p::Real, λ1::Real, λn::Real) where T <: Real
        n > 1 || throw(ArgumentError("n must be greater than 1. Got n=$n."))
        p >= 0 || throw(ArgumentError("p must be non-negative for posdef. Got p=$p."))
        λ1 > 0 || throw(ArgumentError("λ1 must be positive for posdef. Got λ1=$λ1."))
        λn > λ1 || throw(ArgumentError("λn must be greater than λ1. Got λ1=$λ1, λn=$λn."))
        return new{T}(n, T(p), T(λ1), T(λn))
    end
end

# constructors
function Strakos(n::Integer, p::Real, λ1::Real, λn::Real)
    p_, λ1_, λn_ = promote(p, λ1, λn)
    T = typeof(p_)
    return Strakos{T}(n, p_, λ1_, λn_)
end

Strakos(n::Integer) = Strakos(n, 0.5, 0.1, 100)
Strakos{T}(n::Integer) where T = Strakos{T}(n, 0.5, 0.1, 100)

# metadata
@properties Strakos [:eigen, :posdef, :symmetric, :illcond]

# properties
size(A::Strakos) = (A.n, A.n)

# functions
@inline Base.@propagate_inbounds function getindex(A::Strakos{T}, i::Integer, j::Integer) where T
    if i==j
        return T( A.λ1 + ((i-1)/(A.n-1))*(A.λn-A.λ1)*A.p^(A.n-i) )
    else 
        return zero(T)
    end
end
