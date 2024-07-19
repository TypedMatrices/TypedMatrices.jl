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
list_matrices() = list_matrices(Group[], Property[])
list_matrices(properties::Property...) = list_matrices(Group[], collect(properties))
list_matrices(groups::Group...) = list_matrices(collect(groups), Property[])
function list_matrices(groups::Vector{Group}, props::Vector{Property})
    # check properties
    assert_properties_exists(props)

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
