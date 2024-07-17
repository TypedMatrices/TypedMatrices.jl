"""
Typed matrices module. Provides matrices utilizing Julia type system.
"""
module TypedMatrices

using LinearAlgebra

import Base: getindex, size

include("types.jl")
include("metadata.jl")

# all matrices
include("matrices/index.jl")

end
