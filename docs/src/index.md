# TypedMatrices.jl

Welcome to the documentation of `TypedMatrices.jl`, an extensible matrix collection for Julia. The matrices in the library can be used to test algorithms or check (and potentially disprove) linear algebra conjectures numerically.

The package relies on the Julia type system to enhance performance by improving the matrix generation time and reducing storage requirements.

To get started, check out the [Getting Started](@ref) section.

## Features

- Each special matrix has its own Julia type, and users can define new types compatible with the package using the interface provided.
- Many linear algebra operations are implemented using explicit formulas, when known, to enhance performance.
- The matrices in the collection can be filtered by property, to find examples that satisfy a set of properties of interest.
- Users can create matrix groups to retrieve and organize the types in the collection.
