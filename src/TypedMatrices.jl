"""
Typed matrices module. Provides matrices utilizing Julia type system.
"""
module TypedMatrices

using LinearAlgebra

import Base: getindex, size, inv

include("types.jl")
include("metadata.jl")

# all matrices
include("matrices/index.jl")

end
