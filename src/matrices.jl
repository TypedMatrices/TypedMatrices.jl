export
    list_groups,
    add_to_groups,
    remove_from_group,
    remove_from_all_groups,
    save_group,
    load_group,
    list_matrices

# matrix groups
const MATRIX_GROUPS = Dict{Group,Set{Type{<:AbstractMatrix}}}()
const GROUP_BUILTIN = Group(:builtin)
const GROUP_USER = Group(:user)

# default groups
MATRIX_GROUPS[GROUP_BUILTIN] = Set()
MATRIX_GROUPS[GROUP_USER] = Set()

# include matrices
include("matrices/index.jl")

"""
    list_groups()

List all matrix groups.
"""
list_groups() = collect(keys(MATRIX_GROUPS))

"""
    add_to_groups(type, groups)

Add a matrix type to groups. If a group does not exist, it will be created.

Groups `:builtin` and `:user` are special groups. It is suggested always to add matrices to the `:user` group.

`groups` can be vector/varargs of `Group` or symbol.

See also [`remove_from_group`](@ref), [`remove_from_all_groups`](@ref).

# Examples
```julia-repl
julia> add_to_groups(Matrix, [Group(:user), Group(:test)])

julia> add_to_groups(Matrix, Group(:user), Group(:test))

julia> add_to_groups(Matrix, [:user, :test])

julia> add_to_groups(Matrix, :user, :test)
```
"""
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

"""
    remove_from_group(type, group)

Remove a matrix type from a group. If the group is empty, it will be deleted.

`group` can be [`Group`](@ref) or symbol.

See also [`add_to_groups`](@ref), [`remove_from_all_groups`](@ref).

# Examples
```julia-repl
julia> add_to_groups(Matrix, Group(:user))

julia> remove_from_group(Matrix, Group(:user))

julia> add_to_groups(Matrix, :user)

julia> remove_from_group(Matrix, :user)
```
"""
function remove_from_group(type::Type{<:AbstractMatrix}, group::Group)
    # check group is not builtin
    if group == GROUP_BUILTIN
        throw(ArgumentError("Cannot remove matrix from builtin group"))
    end

    # check group exists
    if group ∉ keys(MATRIX_GROUPS)
        throw(ArgumentError("Group $group does not exist"))
    end

    # check type exists in group
    if type ∉ MATRIX_GROUPS[group]
        throw(ArgumentError("Matrix type $type does not exist in group $group"))
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

"""
    remove_from_all_groups(type)

Remove a matrix type from all groups. If a group is empty, it will be deleted.

See also [`add_to_groups`](@ref), [`remove_from_group`](@ref).

# Examples
```julia-repl
julia> remove_from_all_groups(Matrix)
```
"""
function remove_from_all_groups(type::Type{<:AbstractMatrix})
    for group = keys(MATRIX_GROUPS)
        if group != GROUP_BUILTIN && type ∈ MATRIX_GROUPS[group]
            remove_from_group(type, group)
        end
    end
end

"""
    save_group(group, file_name)

Save matrices to a group.

`group` can be [`Group`](@ref) or symbol.

See also [`load_group`](@ref).

# Examples
```julia-repl
julia> save_group(Group(:user), "user_matrices.txt")

julia> save_group(:user, "user_matrices.txt")
```
"""
function save_group(group::Group, file_name::String)
    if group ∉ keys(MATRIX_GROUPS)
        throw(ArgumentError("Group $group does not exist"))
    end

    group_matrices = MATRIX_GROUPS[group]
    open(file_name, "w") do io
        for matrix in group_matrices
            println(io, matrix)
        end
    end
end

# save group alternative interfaces
save_group(group::Symbol, file_name::String) = save_group(Group(group), file_name)

"""
    load_group(group, file_name)

Load matrices to a group.

`group` can be [`Group`](@ref) or symbol.

See also [`save_group`](@ref).

# Examples
```julia-repl
julia> load_group(Group(:user), "user_matrices.txt")

julia> load_group(:user, "user_matrices.txt")
```
"""
function load_group(group::Group, file_name::String)
    # check group is builtin
    if group == GROUP_BUILTIN
        throw(ArgumentError("Cannot load matrices to builtin group"))
    end

    group_matrices = Set()
    open(file_name, "r") do io
        for line in eachline(io)
            matrix = Symbol(line)
            try
                push!(group_matrices, eval(matrix))
            catch
                throw(UndefVarError(matrix, "Error loading matrices from file $file_name, matrix $matrix does not exist"))
            end
        end
    end
    MATRIX_GROUPS[group] = group_matrices
end

# load group alternative interfaces
load_group(group::Symbol, file_name::String) = load_group(Group(group), file_name)

"""
    list_matrices(groups, props)

List all matrices that are in groups and have properties.

`groups` can be vector/varargs of [`Group`](@ref) or symbol.

`props` can be vector/varargs of [`Property`](@ref), symbol, subtype of PropertyTypes.AbstractProperty or instance of AbstractProperty.

# Examples
```julia-repl
julia> list_matrices()

julia> list_matrices([Group(:builtin), Group(:user)], [Property(:symmetric), Property(:inverse)])

julia> list_matrices(Property(:symmetric), Property(:inverse))

julia> list_matrices([Property(:symmetric), Property(:inverse)])

julia> list_matrices(:symmetric, :inverse)

julia> list_matrices([:symmetric, :inverse])

julia> list_matrices(PropertyTypes.Symmetric, PropertyTypes.Inverse)

julia> list_matrices([PropertyTypes.Symmetric, PropertyTypes.Inverse])

julia> list_matrices(PropertyTypes.Symmetric(), PropertyTypes.Inverse())

julia> list_matrices([PropertyTypes.Symmetric(), PropertyTypes.Inverse()])

julia> list_matrices(Group(:builtin), Group(:user))

julia> list_matrices([Group(:builtin), Group(:user)])
```
"""
function list_matrices(groups::Vector{Group}, props::Vector{Property})
    # check properties
    check_properties_exist(props...)

    # groups
    groups_results = union(values(MATRIX_GROUPS)...)
    for group = groups
        if group ∉ keys(MATRIX_GROUPS)
            throw(ArgumentError("Group $group does not exist"))
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
