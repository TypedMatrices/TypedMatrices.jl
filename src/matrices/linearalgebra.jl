import LinearAlgebra: Tridiagonal, SymTridiagonal

@properties Tridiagonal [:illcond]
@properties SymTridiagonal [:symmetric, :inverse, :illcond, :posdef, :eigen]
