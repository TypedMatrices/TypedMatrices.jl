# Getting Started

## Installation

TypedMatrices.jl is a registered package in the Julia package registry. Use Julia's package manager to install it:

```julia-repl
pkg> add TypedMatrices
```

## Setup

Use the package:

```@repl getting-started
using TypedMatrices
```

You can list all matrices available with [`list_matrices`](@ref):

```@repl getting-started
list_matrices()
```

## Creating Matrices

Each type of matrix has its own type and constructors. For example, to create a 5x5 [Hilbert](@ref) matrix:

```@repl getting-started
h = Hilbert(5)
```

Most matrices can accept a type parameter to specify the element type. For example, to create a 5x5 Hilbert matrix with `Float64` elements:

```@repl getting-started
Hilbert{Float64}(5)
```

Please check [Builtin Matrices](@ref) for all available builtin matrices.

## Properties

Matrix has properties like `symmetric`, `illcond`, and `posdef`. Function [`properties`](@ref) can be used to get the properties of a matrix:

```@repl getting-started
properties(Hilbert)
```

You can also check properties of a matrix instance for convinience:

```@repl getting-started
properties(h)
```

To view all available properties, use [`list_properties`](@ref):

```@repl getting-started
list_properties()
```

## Grouping

This package has a grouping feature to group matrices. All builtin matrices are in the `builtin` group, we also create a `user` group for user-defined matrices. You can list all groups with:

```@repl getting-started
list_groups()
```

To add a matrix to groups and enable it to be listed by [`list_matrices`](@ref), use [`add_to_groups`](@ref):

```@repl getting-started
add_to_groups(Matrix, :user, :test)
list_matrices(Group(:user))
```

We can also add builtin matrices to our own groups:

```@repl getting-started
add_to_groups(Hilbert, :test)
list_matrices(Group(:test))
```

To remove a matrix from a group or all groups, use [`remove_from_group`](@ref) or [`remove_from_all_groups`](@ref). The empty group will automatically be removed:

```@repl getting-started
remove_from_group(Hilbert, :test)
remove_from_all_groups(Matrix)
list_groups()
```

## Finding Matrices

[`list_matrices`](@ref) is very powerful to list matrices, and filter by groups and properties. All arguments are "and" relationship, i.e. listed matrices must satisfy all conditions.

For example, to list all matrices in the `builtin` group, and all matrices with `symmetric` property:

```@repl getting-started
list_matrices(Group(:builtin))
list_matrices(Property(:symmetric))
```

To list all matrices in the `builtin` group with `inverse`, `illcond`, and `eigen` properties:

```@repl getting-started
list_matrices(
    [
        Group(:builtin),
    ],
    [
        Property(:inverse),
        Property(:illcond),
        Property(:eigen),
    ]
)
```

To list all matrices with `symmetric`, `eigen`, and `posdef` properties:

```@repl getting-started
list_matrices(:symmetric, :eigen, :posdef)
```

There are many alternative interfaces using `list_matrices`, please check the [`list_matrices`](@ref) or use Julia help system for more information.
