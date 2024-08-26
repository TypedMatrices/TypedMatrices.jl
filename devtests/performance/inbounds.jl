using BenchmarkTools

@inline function f1(A, i)
    @boundscheck checkbounds(A, i)
    return @inbounds g(1:2, -1)
end

@inline Base.@propagate_inbounds function f2(A, i)
    @boundscheck checkbounds(A, i)
    return g(1:2, -1)
end

@inline function g(A, i)
    @boundscheck checkbounds(A, i)
    return "g: accessing ($A)[$i]"
end

function test_f1()
    for i = 1:100000
        @inbounds f1(1:2, -1)
    end
end

function test_f2()
    for i = 1:100000
        @inbounds f2(1:2, -1)
    end
end

function main()
    @inbounds f1(1:2, -1)
    @inbounds f2(1:2, -1)

    t1 = @benchmark test_f1()
    t2 = @benchmark test_f2()
    display(t1)
    display(t2)
end

main()
