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
The matrix is bidiagonal (eigher upper or lower)..
"""
struct Bidiagonal <: AbstractProperty end
"""
The matrix has binary entries.
"""
struct Binary <: AbstractProperty end
"""
The matrix is a Circulant matrix.
"""
struct Circulant <: AbstractProperty end
"""
The matrix has complex entries.
"""
struct Complex <: AbstractProperty end
"""
Correlation
"""
struct Correlation <: AbstractProperty end
"""
Defective
"""
struct Defective <: AbstractProperty end
"""
DiagDom
"""
struct DiagDom <: AbstractProperty end
"""
Part of the eigensystem of the matrix is explicitly known.
"""
struct Eigen <: AbstractProperty end
"""
The matrix has a fixed size.
"""
struct FixedSize <: AbstractProperty end
"""
An adjacency matrix of a graph.
"""
struct Graph <: AbstractProperty end
"""
The matrix is a Hankel matrix.
"""
struct Hankel <: AbstractProperty end
"""
The matrix is a Hessenberg matrix.
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
InfDiv
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
The matrix is a Involutory matrix.
"""
struct Involutory <: AbstractProperty end
"""
Nilpotent
"""
struct Nilpotent <: AbstractProperty end
"""
Nonneg
"""
struct NonNeg <: AbstractProperty end
"""
Normal
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
RankDef
"""
struct RankDef <: AbstractProperty end
"""
The matrix is rectangular.
"""
struct Rectangular <: AbstractProperty end
"""
The output is a test problem for Regularization Methods.
"""
struct RegProb <: AbstractProperty end
"""
SingVal
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
The matrix is triangular (eigher upper or lower).
"""
struct Triangular <: AbstractProperty end
"""
The matrix is tridiagonal.
"""
struct Tridiagonal <: AbstractProperty end
"""
The matrix is a Toeplitz matrix.
"""
struct Toeplitz <: AbstractProperty end
"""
TotNonNeg
"""
struct TotNonNeg <: AbstractProperty end
"""
TotPos
"""
struct TotPos <: AbstractProperty end
"""
Unimodular
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
