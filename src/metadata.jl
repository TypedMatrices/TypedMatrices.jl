export
    list_properties,
    @properties,
    properties

# property list
const PROPERTIES = Dict{Type{<:PropertyTypes.AbstractProperty},Property}(
    type => Property(symbol) for (type, symbol) = Dict(
        PropertyTypes.Symmetric => :symmetric,
        PropertyTypes.Inverse => :inverse,
        PropertyTypes.IllCond => :illcond,
        PropertyTypes.Involutory => :involutory,
        PropertyTypes.Integer => :integer,
        PropertyTypes.PosDef => :posdef,
        PropertyTypes.Eigen => :eigen,
        PropertyTypes.Sparse => :sparse,
        PropertyTypes.Random => :random,
        PropertyTypes.RegProb => :regprob,
        PropertyTypes.Graph => :graph,
        PropertyTypes.TotNonNeg => :totnonneg,
        PropertyTypes.TotPos => :totpos,
        PropertyTypes.InfDiv => :infdiv,
        PropertyTypes.Indefinite => :indefinite,
        PropertyTypes.Defective => :defective,
        PropertyTypes.Nilpotent => :nilpotent,
        PropertyTypes.Hessenberg => :hessenberg,
        PropertyTypes.Toeplitz => :toeplitz,
        PropertyTypes.Binary => :binary,
        PropertyTypes.RankDef => :rankdef,
        PropertyTypes.Circulant => :circulant,
        PropertyTypes.Normal => :normal,
        PropertyTypes.Bidiagonal => :bidiagonal,
        PropertyTypes.Tridiagonal => :tridiagonal,
        PropertyTypes.SingVal => :singval,
        PropertyTypes.Rectangular => :rectangular,
        PropertyTypes.Hankel => :hankel,
        PropertyTypes.DiagDom => :diagdom,
        PropertyTypes.NonNeg => :nonneg,
        PropertyTypes.Unimodular => :unimodular,
        PropertyTypes.Positive => :positive,
        PropertyTypes.FixedSize => :fixedsize
        )
)

"""
    list_properties()

List all properties.
```
"""
list_properties() = collect(values(PROPERTIES))

"""
    check_propertie_types(props::DataType...)

Check properties types are valid, i.e., are subtypes of `PropertyTypes.AbstractProperty`.

# Examples
```julia-repl
julia> check_propertie_types(PropertyTypes.Symmetric, PropertyTypes.Inverse)

julia> check_propertie_types(Int)
ERROR: ArgumentError: Int64 is not a property type
```
"""
function check_propertie_types(props::DataType...)
    for prop = props
        prop <: PropertyTypes.AbstractProperty || throw(ArgumentError("$prop is not a property type"))
    end
end

"""
    check_properties_exists(props::Property...)

Check properties exists.

# Examples
```julia-repl
julia> check_properties_exists(Property(:symmetric), Property(:inverse))

julia> check_properties_exists(Property(:symmetric), Property(:notexists))
ERROR: ArgumentError: Property Property(:notexists) not exists
```
"""
function check_properties_exists(props::Property...)
    for prop = props
        prop ∈ values(PROPERTIES) || throw(ArgumentError("Property $prop not exists"))
    end
end

"""
    property_types_to_properties(props::DataType...) -> Vector{Property}

Convert property types to properties.

# Examples
```julia-repl
julia> property_types_to_properties(PropertyTypes.Symmetric, PropertyTypes.Inverse)
2-element Vector{Property}:
 Property(:symmetric)
 Property(:inverse)
```
"""
function property_types_to_properties(props::DataType...)::Vector{Property}
    check_propertie_types(props...)
    return [PROPERTIES[prop] for prop = props]
end

"""
    @properties Type [propa, propb, ...]

Register properties for a type. The properties are a vector of symbols.

See also: [`properties`](@ref).

# Examples
```julia-repl
julia> @properties Matrix [:symmetric, :inverse, :illcond, :posdef, :eigen]
```
"""
macro properties(type::Symbol, ex::Expr)
    return quote
        register_properties($(esc(type)), $ex)
    end
end

"""
    register_properties(T::Type, props::Vector{Property})

Register properties for a type.

See also: [`@properties`](@ref).

# Examples
```julia-repl
julia> register_properties(Matrix, [Property(:symmetric), Property(:inverse), Property(:illcond), Property(:posdef), Property(:eigen)])

julia> register_properties(Matrix, Property(:symmetric), Property(:inverse), Property(:illcond), Property(:posdef), Property(:eigen))

julia> register_properties(Matrix, [:symmetric, :inverse, :illcond, :posdef, :eigen])

julia> register_properties(Matrix, PropertyTypes.Symmetric, PropertyTypes.Inverse, PropertyTypes.IllCond, PropertyTypes.PosDef, PropertyTypes.Eigen)

julia> register_properties(Matrix, [PropertyTypes.Symmetric, PropertyTypes.Inverse, PropertyTypes.IllCond, PropertyTypes.PosDef, PropertyTypes.Eigen])

julia> register_properties(Matrix, PropertyTypes.Symmetric(), PropertyTypes.Inverse(), PropertyTypes.IllCond(), PropertyTypes.PosDef(), PropertyTypes.Eigen())

julia> register_properties(Matrix, [PropertyTypes.Symmetric(), PropertyTypes.Inverse(), PropertyTypes.IllCond(), PropertyTypes.PosDef(), PropertyTypes.Eigen()])
```
"""
function register_properties(T::Type, props::Vector{Property})
    # check props
    check_properties_exists(props...)

    # register properties
    @eval properties(::Type{<:$T}) = $props

    # return nothing
    return
end

# register properties alternative interfaces
register_properties(T::Type, props::Property...) = register_properties(T, collect(props))
register_properties(T::Type, props::Symbol...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{Symbol}) = register_properties(T, [Property(prop) for prop = props])
register_properties(T::Type, props::DataType...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{DataType}) = register_properties(T, property_types_to_properties(props...))
register_properties(T::Type, props::PropertyTypes.AbstractProperty...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{PropertyTypes.AbstractProperty}) = register_properties(T, [typeof(prop) for prop = props])

"""
    properties(type)
    properties(matrix)

Get the properties of a type or matrix.

See also: [`@properties`](@ref).

# Examples
```julia-repl
julia> @properties Matrix [:symmetric, :posdef]

julia> properties(Matrix)
2-element Vector{Property}:
 Property(:symmetric)
 Property(:posdef)

julia> properties(Matrix(ones(1, 1)))
2-element Vector{Property}:
 Property(:symmetric)
 Property(:posdef)
```
"""
properties(::Type{<:AbstractMatrix})::Vector{Property} = []
properties(m::AbstractMatrix) = properties(typeof(m))
