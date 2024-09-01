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
abstract type AbstractProperty end
struct Symmetric <: AbstractProperty end
struct Inverse <: AbstractProperty end
struct Involutory <: AbstractProperty end
struct Integer <: AbstractProperty end
struct IllCond <: AbstractProperty end
struct PosDef <: AbstractProperty end
struct Eigen <: AbstractProperty end
struct Sparse <: AbstractProperty end
struct Random <: AbstractProperty end
struct RegProb <: AbstractProperty end
struct Graph <: AbstractProperty end
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
