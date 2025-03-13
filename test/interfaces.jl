function sum_elements(A::AbstractMatrix)
    return sum(A)
end

# test_algorithm
@suppress begin
    @test isa(test_algorithm(sum_elements, [1, 2, 3], errors_as_warnings=true), Vector)
    @test isa(test_algorithm(sum_elements, [1, 2, 3], ignore_errors=true), Vector)
    @test isa(test_algorithm(sum_elements, [1, 2, 3], errors_as_warnings=true, ignore_errors=true), Vector)
    @test isa(test_algorithm(sum_elements, [1, 2, 3], ignore_errors=true, excludes=[Hilbert]), Vector)
    @test_throws ArgumentError test_algorithm(sum_elements, [1, 2, 3])
end
