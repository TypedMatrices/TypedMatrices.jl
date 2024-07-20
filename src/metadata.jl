export
    list_properties,
    @properties,
    properties

# property list
const PROPERTIES = [Property(i) for i in [
    :symmetric,
    :inverse,
    :illcond,
    :posdef,
    :eigen,
    :sparse,
    :random,
    :regprob,
    :graph,
]]

# list properties
list_properties() = PROPERTIES

# assert properties exists
function assert_properties_exists(props::Vector{Property})
    for prop in props
        if prop ∉ PROPERTIES
            throw(ArgumentError("Property $prop not exists"))
        end
    end
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
    assert_properties_exists(props)

    # register properties
    @eval properties(::Union{Type{$T},Type{$T{T}}}) where {T} = $props
end

# register properties alternative interfaces
register_properties(T::Type, props::Vector{Symbol}) = register_properties(T, [Property(prop) for prop in props])
register_properties(T::Type, props::Symbol...) = register_properties(T, collect(props))
register_properties(T::Type, props::Property...) = register_properties(T, collect(props))

# properties function interfaces
properties(::Type{<:AbstractMatrix})::Vector{Property} = []
properties(m::AbstractMatrix) = properties(typeof(m))
