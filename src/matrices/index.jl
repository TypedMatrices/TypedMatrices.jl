export
    Binomial,
    Cauchy,
    ChebSpec,
    Chow,
    Circulant,
    Clement,
    Companion,
    Comparison,
    Cycol,
    DingDong,
    Dorr,
    Fiedler,
    Forsythe,
    Frank,
    GCDMat,
    Golub,
    Grcar,
    Hadamard,
    Hankel,
    Hilbert,
    InverseHilbert,
    Involutory,
    Kahan,
    KMS,
    Lehmer,
    Lotkin,
    Magic,
    Minij,
    Moler,
    Neumann,
    Oscillate,
    Parter,
    Pascal,
    Pei,
    Poisson,
    Prolate,
    Randcorr,
    Rando,
    RandSVD,
    RIS,
    Rohess,
    Rosser,
    Sampling,
    Toeplitz,
    Triw,
    Wathen,
    Wilkinson

# include all matrices
include("linearalgebra.jl")
include("binomial.jl")
include("cauchy.jl")
include("chebspec.jl")
include("chow.jl")
include("circulant.jl")
include("clement.jl")
include("companion.jl")
include("comparison.jl")
include("cycol.jl")
include("dingdong.jl")
include("dorr.jl")
include("fiedler.jl")
include("forsythe.jl")
include("frank.jl")
include("gcdmat.jl")
include("golub.jl")
include("grcar.jl")
include("hadamard.jl")
include("hankel.jl")
include("hilbert.jl")
include("inversehilbert.jl")
include("involutory.jl")
include("kahan.jl")
include("kms.jl")
include("lehmer.jl")
include("lotkin.jl")
include("magic.jl")
include("minij.jl")
include("moler.jl")
include("neumann.jl")
include("oscillate.jl")
include("parter.jl")
include("pascal.jl")
include("pei.jl")
include("poisson.jl")
include("prolate.jl")
include("randcorr.jl")
include("rando.jl")
include("randsvd.jl")
include("ris.jl")
include("rohess.jl")
include("rosser.jl")
include("sampling.jl")
include("toeplitz.jl")
include("triw.jl")
include("wathen.jl")
include("wilkinson.jl")

# add matrices to builtin group
MATRIX_GROUPS[GROUP_BUILTIN] = Set([
    Binomial,
    Cauchy,
    ChebSpec,
    Chow,
    Circulant,
    Clement,
    Companion,
    Comparison,
    Cycol,
    DingDong,
    Dorr,
    Fiedler,
    Forsythe,
    Frank,
    GCDMat,
    Golub,
    Grcar,
    Hadamard,
    Hankel,
    Hilbert,
    InverseHilbert,
    Involutory,
    Kahan,
    KMS,
    Lehmer,
    Lotkin,
    Magic,
    Minij,
    Moler,
    Neumann,
    Oscillate,
    Parter,
    Pascal,
    Pei,
    Poisson,
    Prolate,
    Randcorr,
    Rando,
    RandSVD,
    RIS,
    Rohess,
    Rosser,
    Sampling,
    Toeplitz,
    Triw,
    Wathen,
    Wilkinson,
])

# """
#     @builtin MatrixType
#
# Add a matrix type to the builtin group and export it.
#
# # Examples
# ```julia-repl
# julia> @builtin Matrix
# ```
# """
# macro builtin(type::Symbol, file::String)
#     quote
#         export $type
#         include($file)
#         push!(MATRIX_GROUPS[GROUP_BUILTIN], $type)
#     end
# end
#
# include("linearalgebra.jl")
# @builtin Binomial "binomial.jl"
# @builtin Cauchy "cauchy.jl"
# @builtin ChebSpec "chebspec.jl"
# @builtin Chow "chow.jl"
# @builtin Circulant "circulant.jl"
# @builtin Clement "clement.jl"
# @builtin Companion "companion.jl"
# @builtin DingDong "dingdong.jl"
# @builtin Fiedler "fiedler.jl"
# @builtin Forsythe "forsythe.jl"
# @builtin Frank "frank.jl"
# @builtin Golub "golub.jl"
# @builtin Grcar "grcar.jl"
# @builtin Hadamard "hadamard.jl"
# @builtin Hankel "hankel.jl"
# @builtin Hilbert "hilbert.jl"
# @builtin InverseHilbert "inversehilbert.jl"
# @builtin Involutory "involutory.jl"
# @builtin Kahan "kahan.jl"
# @builtin KMS "kms.jl"
# @builtin Lehmer "lehmer.jl"
# @builtin Lotkin "lotkin.jl"
# @builtin Magic "magic.jl"
# @builtin Minij "minij.jl"
# @builtin Moler "moler.jl"
# @builtin Neumann "neumann.jl"
# @builtin Oscillate "oscillate.jl"
# @builtin Parter "parter.jl"
# @builtin Pascal "pascal.jl"
# @builtin Pei "pei.jl"
# @builtin Poisson "poisson.jl"
# @builtin Prolate "prolate.jl"
# @builtin Randcorr "randcorr.jl"
# @builtin Rando "rando.jl"
# @builtin RandSVD "randsvd.jl"
# @builtin Rohess "rohess.jl"
# @builtin Rosser "rosser.jl"
# @builtin Sampling "sampling.jl"
# @builtin Toeplitz "toeplitz.jl"
# @builtin Triw "triw.jl"
# @builtin Wathen "wathen.jl"
# @builtin Wilkinson "wilkinson.jl"
