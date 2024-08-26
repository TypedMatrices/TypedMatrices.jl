using LinearAlgebra
using MatrixDepot
using TypedMatrices

function compare(name::String, typedT::Type{T}, args...) where {T<:AbstractMatrix}
    depot = matrixdepot(name, args...)
    typed = typedT(args...)
    # display(depot)
    # display(typed)
    # @show norm(typed - depot)
    return typed ≈ depot
end

function linearalgebra_is_tests(A::AbstractMatrix)
    return Dict(
        :diag => isdiag(A),
        :hermitian => ishermitian(A),
        :posdef => isposdef(A),
        :symmetric => issymmetric(A),
    )
end

MT = Clement
name = "clement"

# linear algebra properties
for i = 1:10
    matrix = MT(i)
    test_result_type = linearalgebra_is_tests(matrix)
    test_result_matrix = linearalgebra_is_tests(Matrix(matrix))
    if test_result_type != test_result_matrix || true
        display(matrix)
        @show i, test_result_type, test_result_matrix
    end
end

# compare elements
for i = 1:10
    result = compare(name, MT, i)
    if !result || false
        @show i, result
    end
end
