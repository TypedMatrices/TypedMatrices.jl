export
    list_groups,
    list_matrices,
    Hilbert,
    InverseHilbert,
    Minij

# include all matrices
include("hilbert.jl")
include("inversehilbert.jl")
include("minij.jl")

# matrix groups
const MATRIX_GROUPS = Dict{Group,Set{Type{<:AbstractMatrix}}}()
MATRIX_GROUPS[Group(:builtin)] = Set([
    Hilbert,
    InverseHilbert,
    Minij,
])
MATRIX_GROUPS[Group(:user)] = Set([])

# group functions
list_groups() = collect(keys(MATRIX_GROUPS))
# function add_to_group(::Type{<:AbstractMatrix}, group::Symbol...=:user)
# function remove_from_all_groups(::Type{<:AbstractMatrix})
# function remove_from_group(::Type{<:AbstractMatrix}, group::Symbol)

# list matrices
function list_matrices(groups::Vector{Group}, props::Vector{Property})
    # check properties
    check_properties_exists(props...)

    # groups
    groups_results = union(values(MATRIX_GROUPS)...)
    for group = groups
        if group ∉ keys(MATRIX_GROUPS)
            throw(ArgumentError("Group $group not exists"))
        else
            intersect!(groups_results, MATRIX_GROUPS[group])
        end
    end

    # properties
    results::Vector{Type{<:AbstractMatrix}} = []
    for matrix = groups_results
        if all(props .∈ Ref(properties(matrix)))
            push!(results, matrix)
        end
    end

    # return
    return results
end

# list matrices alternative interfaces - empty
list_matrices() = list_matrices(Group[], Property[])

# list matrices alternative interfaces - properties
list_matrices(props::Property...) = list_matrices(collect(props))
list_matrices(props::Vector{Property}) = list_matrices(Group[], props)
list_matrices(props::Symbol...) = list_matrices(collect(props))
list_matrices(props::Vector{Symbol}) = list_matrices([Property(prop) for prop = props])
list_matrices(props::DataType...) = list_matrices(collect(props))
list_matrices(props::Vector{DataType}) = list_matrices(property_types_to_properties(props...))
list_matrices(props::PropertyTypes.AbstractProperty...) = list_matrices(collect(props))
list_matrices(props::Vector{PropertyTypes.AbstractProperty}) = list_matrices([typeof(prop) for prop = props])

# list matrices alternative interfaces - groups
list_matrices(groups::Group...) = list_matrices(collect(groups))
list_matrices(groups::Vector{Group}) = list_matrices(groups, Property[])
