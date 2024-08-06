using Test
using TypedMatrices
using LinearAlgebra

const builtin_matrices = list_matrices(Group(:builtin))

@testset "TypedMatrices.jl" begin
    include("types.jl")
    include("metadata.jl")
    include("matrices.jl")

    @testset "matrices" begin
        for file = readdir("matrices")
            include("matrices/$file")
        end
    end
end
