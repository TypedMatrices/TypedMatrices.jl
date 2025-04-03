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
function add_implied_properties(properties::Vector{Property})
    output = copy(properties)
    return add_implied_properties!(output)
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
macro properties(type_name::Symbol, base_properties::Expr, property_to_constructor_assignment::Expr=:(Dict{Vector{Symbol}, Function}()))
    # Get the actual properties and dictionary from the macro arguments.
    evaluated_property_to_constructor_assignment = eval(property_to_constructor_assignment)
    evaluated_base_properties = eval(base_properties)

    # Create the expression for the properties function.
    all_keys = collect(keys(evaluated_property_to_constructor_assignment))
    all_symbols = union(evaluated_base_properties, all_keys...)
    properties_function = quote
        register_properties($(esc(type_name)), $all_symbols)
    end

    # Create the expression for the constructor function.
    function_name = string(type_name)
    constructor_function = quote
        register_constructor($(esc(type_name)), $function_name, $evaluated_base_properties, $evaluated_property_to_constructor_assignment)
    end

    return Expr(:toplevel, properties_function, constructor_function)
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
    return nothing
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

    register_constructor(type_name::Type, function_name::String, props::Vector{Property}, property_to_constructor_assignment::Dict{Vector{Property}, Function})

    register_constructor(type_name::Type, function_name::String, props::Vector{Symbol}, property_to_constructor_assignment::Dict{Vector{Symbol}, Function})

    Register a constructor for a type. The constructor is a function that takes a vector of properties and an integer
    and returns a matrix of the given type with the required properties.

    # Examples
    ```julia-repl
    julia> register_constructor(Matrix, "Matrix", [:symmetric, :posdef], Dict{Vector{Symbol}, Function}(
        [:symmetric] => (n) -> Matrix(n, n),
        [:posdef] => (n) -> Matrix(n, n)
    ))
    ```
"""
function register_constructor(type_name::Type, function_name::String, props::Vector{Property}, property_to_constructor_assignment::Dict{Vector{Property}, Function})
    fname = Symbol(function_name)
    if isempty(property_to_constructor_assignment)
        # The function has no parameter-dependent properties.
        @eval $fname(input_properties::Vector{Symbol}, n::Int) = $type_name(n)
        @eval $fname(input_properties::Vector{Property}, n::Int) = $type_name(n)
    else
        # The function has parameter-dependent properties.
        add_implied_properties!(props)
        @eval $fname(input_properties::Vector{Property}, n::Int) = begin
            add_implied_properties!(input_properties)
            for (key_properties, action) in $property_to_constructor_assignment
                if issubset(input_properties, add_implied_properties(key_properties) ∪ $props)
                    return action(n)
                end
            end
            throw(ArgumentError("No constructor for the given set of properties: \$input_properties"))
        end
        @eval $fname(input_properties::Vector{Symbol}, n::Int) = $fname([Property(prop) for prop in input_properties], n)
    end
    return nothing
end
register_constructor(type_name::Type, function_name::String, props::Vector{Symbol}, property_to_constructor_assignment::Dict{Vector{Symbol}, Function}) =
    register_constructor(type_name, function_name,
        [Property(prop) for prop = props],
        Dict{Vector{Property}, Function}([Property(sym) for sym in k] => v for (k, v) in property_to_constructor_assignment))
register_constructor(type_name::Type, function_name::String, props::Vector{Property}, property_to_constructor_assignment::Dict{Vector{Symbol}, Function}) =
    register_constructor(type_name, function_name, props,
        Dict{Vector{Property}, Function}([Property(sym) for sym in k] => v for (k, v) in property_to_constructor_assignment))

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
