export
    test_algorithm

"""
    test_algorithm(func, sizes, props, errors_as_warnings=false, ignore_errors=false, excludes=[])

Test an algorithm with all matrix types and sizes.

# Arguments
- `func::Function`: The function to test, which accepts a matrix as input.
- `sizes::Vector{Integer}`: The sizes to test.
- `props::Vector{Property}=Property[]`: The properties to find matrices.
- `errors_as_warnings::Bool=false`: If true, errors will be shown as warnings.
- `ignore_errors::Bool=false`: If true, errors will be ignored.
- `excludes::Vector=[]`: The matrix types to exclude.

The `errors_as_warnings` and `ignore_errors` options can be true at the same time. In this case, errors will be ignored.
"""
function test_algorithm(
    func::Function,
    sizes::Vector{Integer};
    props::Vector{Property}=Property[],
    errors_as_warnings::Bool=false,
    ignore_errors::Bool=false,
    excludes::Vector=[]
)
    # check errors_as_warnings and ignore_errors
    if errors_as_warnings && ignore_errors
        @warn "errors_as_warnings and ignore_errors cannot be true at the same time. Errors will be ignored."
    end

    results = []
    matrix_types = list_matrices(props)
    for matrix_type in matrix_types
        # skip if matrix_type is in excludes
        if matrix_type in excludes
            continue
        end

        for size in sizes
            try
                # create matrix and run function
                A = matrix_type(size)
                result = func(A)
                push!(results, (matrix_type, size, result))
            catch e
                # ignore errors
                if ignore_errors
                    continue
                end

                # errors as warnings
                if errors_as_warnings
                    @warn "Error running $func on $matrix_type with size $size: $e"
                    continue
                end

                # otherwise the error is thrown
                @error "Error running $func on $matrix_type with size $size: $e"
                throw(e)
            end
        end
    end

    # return results
    return results
end
