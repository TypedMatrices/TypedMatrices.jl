export
    list_properties,
    @properties,
    properties

# property list
const PROPERTIES = Dict{Type{<:PropertyTypes.AbstractProperty},Property}(
    type => Property(symbol) for (type, symbol) = Dict(
        PropertyTypes.Bidiagonal => :bidiagonal,
        PropertyTypes.Binary => :binary,
        PropertyTypes.Circulant => :circulant,
        PropertyTypes.Complex => :complex,
        PropertyTypes.Correlation => :correlation,
        PropertyTypes.Defective => :defective,
        PropertyTypes.DiagonallyDominant => :diagdom,
        PropertyTypes.Eigensystem => :eigen,
        PropertyTypes.FixedSize => :fixedsize,
        PropertyTypes.Graph => :graph,
        PropertyTypes.Hankel => :hankel,
        PropertyTypes.Hermitian => :hermitian,
        PropertyTypes.Hessenberg => :hessenberg,
        PropertyTypes.IllConditioned => :illcond,
        PropertyTypes.Indefinite => :indefinite,
        PropertyTypes.InfinitelyDivisible => :infdiv,
        PropertyTypes.Integer => :integer,
        PropertyTypes.Inverse => :inverse,
        PropertyTypes.Involutory => :involutory,
        PropertyTypes.Nilpotent => :nilpotent,
        PropertyTypes.Nonnegative => :nonneg,
        PropertyTypes.Normal => :normal,
        PropertyTypes.Orthogonal => :orthogonal,
        PropertyTypes.Positive => :positive,
        PropertyTypes.PositiveDefinite => :posdef,
        PropertyTypes.PositiveSemidefinite => :possemidef,
        PropertyTypes.Random => :random,
        PropertyTypes.RankDeficient => :rankdef,
        PropertyTypes.Rectangular => :rectangular,
        PropertyTypes.RegularisationProblem => :regprob,
        PropertyTypes.SingularValues => :singval,
        PropertyTypes.Sparse => :sparse,
        PropertyTypes.Symmetric => :symmetric,
        PropertyTypes.Toeplitz => :toeplitz,
        PropertyTypes.TotallyNonnegative => :totnonneg,
        PropertyTypes.TotallyPositive => :totpos,
        PropertyTypes.Triangular => :triangular,
        PropertyTypes.Tridiagonal => :tridiagonal,
        PropertyTypes.Unimodular => :unimodular,
        PropertyTypes.Unitary => :unitary
    )
)

# Handle property implications
struct PropertyImplication
    ifPresent::Set{Property}
    ifAbsent::Set{Property}
    thenAdd::Set{Property}
end

const IMPLICATIONS = [
    PropertyImplication(Set(Property(present)), Set(Property(absent)), Set(Property(toAdd)))
        for (present::Vector{Symbol}, absent::Vector{Symbol}, toAdd::Vector{Symbol}) in [
            ([:bidiagonal], [], [:hessenberg, :sparse, :triangular, :tridiagonal]),
            ([:circulant], [], [:toeplitz, :eigen]),
            ([:complex], [], [:normal]),
            ([:correlation], [], [:symmetric, :possemidef]),
            ([:diagdom], [], [:posdef]),
            ([:hankel], [], [:symmetric]),
            ([:hermitian], [], [:normal]),
            ([:infdiv], [], [:possemidef]),
            ([:involutory], [], [:inverse]),
            ([:involutory, :symmetric], [], [:orthogonal]),
            ([:involutory, :normal], [:complex], [:symmetric, :orthogonal]),
            ([:involutory, :normal, :complex], [], [:hermitian, :unitary]),
            ([:orthogonal], [:complex], [:unitary]),
            ([:positive], [], [:nonneg]),
            ([:posdef], [], [:possemidef]),
            ([:posdef], [:complex], [:symmetric]),
            ([:posdef], [:complex], [:hermitian]),
            ([:symmetric], [], [:normal]),
            ([:symmetric], [:complex], [:hermitian]),
            ([:totnonneg], [], [:nonneg]),
            ([:totnonneg, :hermitian], [], [:possemidef]),
            ([:totpos], [], [:positive]),
            ([:totpos, :hermitian], [], [:posdef]),
            ([:tridiagonal], [], [:hessenberg]),
            ([:unimodular], [], [:integer]),
            ([:unitary], [:complex], [:symmetric])
    ]
]

"""
    add_implied_properties(properties::Set{Symbol})

Add implied properties to a set of properties.

# Examples
```julia-repl
julia> add_implied_properties(Set([:posdef]))
"""
function add_implied_properties!(properties::Vector{Property})
    changed = true
    while changed
        changed = false
        for imp in IMPLICATIONS
            if imp.ifPresent ⊆ properties && isempty(imp.ifAbsent ∩ properties) && !(imp.thenAdd ⊆ properties)
                    append!(properties, setdiff(imp.thenAdd, properties))
                    changed = true
            end
        end
    end
    return properties
end

"""
    list_properties()

List all properties.
"""
list_properties() = collect(values(PROPERTIES))

"""
    check_property_types(props::DataType...)

Check properties types are valid, i.e., are subtypes of `PropertyTypes.AbstractProperty`.

# Examples
```julia-repl
julia> check_property_types(PropertyTypes.Symmetric, PropertyTypes.Inverse)

julia> check_property_types(Int)
ERROR: ArgumentError: Int64 is not a property type
```
"""
function check_property_types(props::DataType...)
    for prop = props
        prop <: PropertyTypes.AbstractProperty || throw(ArgumentError("$prop is not a property type"))
    end
end

"""
    check_properties_exist(props::Property...)

Check properties exist.

# Examples
```julia-repl
julia> check_properties_exist(Property(:symmetric), Property(:inverse))

julia> check_properties_exist(Property(:symmetric), Property(:notexists))
ERROR: ArgumentError: Property Property(:notexists) does not exist
```
"""
function check_properties_exist(props::Property...)
    for prop = props
        prop ∈ values(PROPERTIES) || throw(ArgumentError("Property $prop does not exist"))
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
    check_property_types(props...)
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
    check_properties_exist(props...)
    add_implied_properties!(props)

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
