export
    list_groups,
    add_to_groups,
    remove_from_group,
    remove_from_all_groups,
    list_matrices,
    Binomial,
    Cauchy,
    ChebSpec,
    Chow,
    Circulant,
    Companion,
    Hilbert,
    InverseHilbert,
    Involutory,
    Lotkin,
    Minij

# include all matrices
include("linearalgebra.jl")
include("binomial.jl")
include("cauchy.jl")
include("chebspec.jl")
include("chow.jl")
include("circulant.jl")
include("companion.jl")
include("hilbert.jl")
include("inversehilbert.jl")
include("involutory.jl")
include("lotkin.jl")
include("minij.jl")

# matrix groups
const MATRIX_GROUPS = Dict{Group,Set{Type{<:AbstractMatrix}}}()
const GROUP_BUILTIN = Group(:builtin)
const GROUP_USER = Group(:user)

# default groups and matrices
MATRIX_GROUPS[GROUP_BUILTIN] = Set([
    Binomial,
    Cauchy,
    ChebSpec,
    Chow,
    Circulant,
    Companion,
    Hilbert,
    InverseHilbert,
    Involutory,
    Lotkin,
    Minij,
])
MATRIX_GROUPS[GROUP_USER] = Set([])

# group functions
list_groups() = collect(keys(MATRIX_GROUPS))

# add to groups
function add_to_groups(type::Type{<:AbstractMatrix}, groups::Vector{Group})
    for group = groups
        # check group is builtin
        if group == GROUP_BUILTIN
            throw(ArgumentError("Cannot add matrix to builtin group"))
        end

        # add to group
        if group ∉ keys(MATRIX_GROUPS)
            MATRIX_GROUPS[group] = Set([type])
        else
            push!(MATRIX_GROUPS[group], type)
        end
    end
end

# add to groups alternative interfaces
add_to_groups(type::Type{<:AbstractMatrix}, groups::Group...) = add_to_groups(type, collect(groups))
add_to_groups(type::Type{<:AbstractMatrix}, groups::Symbol...) = add_to_groups(type, collect(groups))
add_to_groups(type::Type{<:AbstractMatrix}, groups::Vector{Symbol}) = add_to_groups(type, [Group(group) for group = groups])

# remove from group
function remove_from_group(type::Type{<:AbstractMatrix}, group::Group)
    # check group is not builtin
    if group == GROUP_BUILTIN
        throw(ArgumentError("Cannot remove matrix from builtin group"))
    end

    # check group exists
    if group ∉ keys(MATRIX_GROUPS)
        throw(ArgumentError("Group $group not exists"))
    end

    # check type exists in group
    if type ∉ MATRIX_GROUPS[group]
        throw(ArgumentError("Matrix type $type not exists in group $group"))
    end

    # remove from group
    delete!(MATRIX_GROUPS[group], type)

    # check if group is empty
    if isempty(MATRIX_GROUPS[group]) && group != GROUP_USER
        delete!(MATRIX_GROUPS, group)
    end
end

# remove from group alternative interfaces
remove_from_group(type::Type{<:AbstractMatrix}, group::Symbol) = remove_from_group(type, Group(group))

# remove from all groups
function remove_from_all_groups(type::Type{<:AbstractMatrix})
    for group = keys(MATRIX_GROUPS)
        if group != GROUP_BUILTIN && type ∈ MATRIX_GROUPS[group]
            remove_from_group(type, group)
        end
    end
end

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
