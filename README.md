# TypedMatrices

[![license][license-img]][license-url]
[![arXiv][arxiv-img]][arxiv-url]
[![action status][action-img]][action-url]
[![codecov][codecov-img]][codecov-url]
[![docs-stable][docs-stable-img]][docs-stable-url]
[![docs-dev][docs-dev-img]][docs-dev-url]
[![release][release-img]][release-url]

An extensible [Julia](https://julialang.org/) matrix collection utilizing type system to enhance performance.

This package provides new matrix types that can be used in Julia [LinearAlgebra](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/). Each matrix is a new subtype of `AbstractMatrix`, they are stored and computed efficiently.

## Usage

Check [documentation][docs-stable-url] for more details.

## Related Packages

We sincerly appreciate the following packages:

- [MatrixDepot.jl](https://github.com/JuliaLinearAlgebra/MatrixDepot.jl): some matrices' generation algorithm are inspired and adapted from this package. Also, most matrices' documentation are adapted from this package.
- [SpecialMatrices.jl](https://github.com/JuliaLinearAlgebra/SpecialMatrices.jl): code structure and some matrices' manipulation functions are inspired and adapted from this package.

## References

- Nicholas J. Higham, "Algorithm 694, A Collection of Test Matrices in MATLAB", *ACM Trans. Math. Software*,  vol. 17. (1991), pp 289-305 [[pdf]](http://www.maths.manchester.ac.uk/~higham/narep/narep172.pdf) [[doi]](https://dx.doi.org/10.1145/114697.116805)

[license-img]: https://shields.io/github/license/TypedMatrices/TypedMatrices.jl
[license-url]: LICENSE
[arxiv-img]: https://img.shields.io/badge/arXiv-2503.11355-b31b1b.svg?logo=arxiv
[arxiv-url]: https://arxiv.org/abs/2503.11355
[action-img]: https://github.com/TypedMatrices/TypedMatrices.jl/actions/workflows/CI.yml/badge.svg?branch=master
[action-url]: https://github.com/TypedMatrices/TypedMatrices.jl/actions/workflows/CI.yml?query=branch%3Amaster
[codecov-img]: https://codecov.io/gh/TypedMatrices/TypedMatrices.jl/graph/badge.svg
[codecov-url]: https://codecov.io/gh/TypedMatrices/TypedMatrices.jl
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://typedmatrices.github.io/TypedMatrices.jl/stable/
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://typedmatrices.github.io/TypedMatrices.jl/dev/
[release-img]: https://shields.io/github/v/release/TypedMatrices/TypedMatrices.jl?display_name=tag&include_prereleases
[release-url]: https://github.com/TypedMatrices/TypedMatrices.jl/releases/latest
