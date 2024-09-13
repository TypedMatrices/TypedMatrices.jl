export
    PropertyTypes,
    Property,
    Group

"""
    PropertyTypes

Types of properties.

See also [`TypedMatrices.Property`](@ref), [`TypedMatrices.list_properties`](@ref).

# Examples
```julia-repl
julia> PropertyTypes.Symmetric
TypedMatrices.PropertyTypes.Symmetric
```
"""
module PropertyTypes
"""
This is an abstract type for properties.
"""
abstract type AbstractProperty end
"""
The matrix is upper or lower bidiagonal.
"""
struct Bidiagonal <: AbstractProperty end
"""
The matrix has entries from a binary set.
"""
struct Binary <: AbstractProperty end
"""
The matrix is circulant.
"""
struct Circulant <: AbstractProperty end
"""
The matrix has complex entries.
"""
struct Complex <: AbstractProperty end
"""
The matrix is a correlation matrix.
"""
struct Correlation <: AbstractProperty end
"""
The matrix is defective.
"""
struct Defective <: AbstractProperty end
"""
The matrix is diagonally dominant.
"""
struct DiagDom <: AbstractProperty end
"""
Part of the eigensystem of the matrix is explicitly known.
"""
struct Eigen <: AbstractProperty end
"""
The matrix is only available in some fixed sizes.
"""
struct FixedSize <: AbstractProperty end
"""
The matrix is the adjacency matrix of a graph.
"""
struct Graph <: AbstractProperty end
"""
The matrix is a Hankel matrix.
"""
struct Hankel <: AbstractProperty end
"""
The matrix is an upper or lower Hessenberg matrix.
"""
struct Hessenberg <: AbstractProperty end
"""
The matrix is ill-conditioned for some parameter values.
"""
struct IllCond <: AbstractProperty end
"""
The matrix is indefinite for some parameter values.
"""
struct Indefinite <: AbstractProperty end
"""
The matrix is infinitely divisible.
"""
struct InfDiv <: AbstractProperty end
"""
The matrix has integer entries.
"""
struct Integer <: AbstractProperty end
"""
The inverse of the matrix is known explicitly.
"""
struct Inverse <: AbstractProperty end
"""
The matrix is involutory for some parameter values.
"""
struct Involutory <: AbstractProperty end
"""
The matrix is nilpotent for some parameter values.
"""
struct Nilpotent <: AbstractProperty end
"""
The matrix is nonnegative for some parameter values.
"""
struct NonNeg <: AbstractProperty end
"""
The matrix is normal.
"""
struct Normal  <: AbstractProperty end
"""
The matrix is orthogonal for some parameter values.
"""
struct Orthogonal <: AbstractProperty end
"""
The matrix is positive for some parameter values.
"""
struct Positive <: AbstractProperty end
"""
The matrix is positive definite for some parameter values.
"""
struct PosDef <: AbstractProperty end
"""
The matrix has random entries.
"""
struct Random <: AbstractProperty end
"""
The matrix is rank deficient.
"""
struct RankDef <: AbstractProperty end
"""
The matrix is rectangular for some parameter values.
"""
struct Rectangular <: AbstractProperty end
"""
The output is a test problem for regularization methods.
"""
struct RegProb <: AbstractProperty end
"""
Part of the singular values and vectors of the matrix is explicitly known.
"""
struct SingVal <: AbstractProperty end
"""
The matrix is sparse.
"""
struct Sparse <: AbstractProperty end
"""
The matrix is symmetric for some parameter values.
"""
struct Symmetric <: AbstractProperty end
"""
The matrix is upper or lower trinagular.
"""
struct Triangular <: AbstractProperty end
"""
The matrix is tridiagonal.
"""
struct Tridiagonal <: AbstractProperty end
"""
The matrix is Toeplitz.
"""
struct Toeplitz <: AbstractProperty end
"""
The matrix is totally nonnegative for some parameter values.
"""
struct TotNonNeg <: AbstractProperty end
"""
The matrix is totally positive for some parameter values.
"""
struct TotPos <: AbstractProperty end
"""
The matrix is unimodular for some parameter values.
"""
struct Unimodular <: AbstractProperty end
end

"""
    Property

Property type. Similar to symbol, just to distinguish it from group.

See also [`list_properties`](@ref), [`@properties`](@ref), [`properties`](@ref).
"""
struct Property
    name::Symbol
end

"""
    Group

Group type. Similar to symbol, just to distinguish it from property.

See also [`list_matrices`](@ref), [`list_groups`](@ref), [`add_to_groups`](@ref),
[`remove_from_group`](@ref), [`remove_from_all_groups`](@ref).
"""
struct Group
    name::Symbol
end
