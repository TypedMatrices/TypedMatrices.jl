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
        PropertyTypes.PosDef => :posdef,
        PropertyTypes.Eigen => :eigen,
        PropertyTypes.Sparse => :sparse,
        PropertyTypes.Random => :random,
        PropertyTypes.RegProb => :regprob,
        PropertyTypes.Graph => :graph,
    )
)

# list properties
list_properties() = collect(values(PROPERTIES))

# check property types
function check_propertie_types(props::DataType...)
    for prop = props
        prop <: PropertyTypes.AbstractProperty || throw(ArgumentError("$prop is not a property type"))
    end
end

# assert properties exists
function check_properties_exists(props::Property...)
    for prop = props
        prop ∈ values(PROPERTIES) || throw(ArgumentError("Property $prop not exists"))
    end
end

# properties types to properties
function property_types_to_properties(props::DataType...)::Vector{Property}
    check_propertie_types(props...)
    return [PROPERTIES[prop] for prop = props]
end

# register properties macro
macro properties(type::Symbol, ex::Expr)
    return quote
        register_properties($(esc(type)), $ex)
    end
end

# register properties
function register_properties(T::Type, props::Vector{Property})
    # check props
    check_properties_exists(props...)

    # register properties
    @eval properties(::Union{Type{$T},Type{$T{T}}}) where {T} = $props
end

# register properties alternative interfaces
register_properties(T::Type, props::Property...) = register_properties(T, collect(props))
register_properties(T::Type, props::Symbol...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{Symbol}) = register_properties(T, [Property(prop) for prop = props])
register_properties(T::Type, props::DataType...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{DataType}) = register_properties(T, property_types_to_properties(props...))
register_properties(T::Type, props::PropertyTypes.AbstractProperty...) = register_properties(T, collect(props))
register_properties(T::Type, props::Vector{PropertyTypes.AbstractProperty}) = register_properties(T, [typeof(prop) for prop = props])

# properties function interfaces
properties(::Type{<:AbstractMatrix})::Vector{Property} = []
properties(m::AbstractMatrix) = properties(typeof(m))
