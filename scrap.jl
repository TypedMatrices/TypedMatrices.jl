using TypedMatrices
using LinearAlgebra

A = Binomial(10)
F = lu(A)

norm(F.L * F.U - A)

h = InverseHilbert{BigFloat}(29)
a = inv(InverseHilbert{BigFloat}(29))
b = inv(Matrix(InverseHilbert{BigFloat}(29)))

#= struct Tridiag{T} <: AbstractMatrix{T}
    a::Vector
    b::Vector
end =#

# Tridiagonal(A::Tridiag) = Tridiagonal(A.a, A.b, A.a)

# methods = methodswith(LinearAlgebra.Tridiagonal)
# Iterate over each method and create a corresponding method for MyTridiag
#= for method in methods
    # Extract method name and signature
    function_name = method.name
    method_signature = method.sig

    arg_types = method_signature.types[2:end]
    println(arg_types[1])

    # Create argument symbols
    args = [Symbol("arg$i::" * string(arg_types[i])) for i in 1:length(arg_types)]
    println(args)

    # Construct the method definition
    #= @eval begin
        println($method.module.$(function_name))
        # import $(method.module).$(function_name)
        function $function_name(mytridiag::Tridiag, $(args...))
            return $function_name(Tridiagonal(mytridiag), $(args...))
        end
    end =#
end
 =#
# Tridiag(a, b) = Tridiagonal(a, b, a)

# @properties MyTridiag [:eigen, :sparse]

# properties(MyTridiag)
# properties(Tridiagonal)