using TextTableRows
using Base.Test

import TextTableRows: perc, count_and_perc

@testset "perc" begin
    @test perc(pi) == "314.2%"
    @test perc(1/3) == "33.3%"
    @test count_and_perc(10, 20) == "10  (50.0%)"
end

@testset "Extrema" begin
    s = Extrema(Int)
    @test isempty(s)
    @test length(s) == 0
    push!(s, 1)
    @test !isempty(s)
    @test minimum(s) == maximum(s) == length(s) == 1
    push!(s, -7)
    @test extrema(s) == (-7,1)
    @test length(s) == 2
    @test repr(s) == "Extrema{$(Int),$(Int)}: 2 values, -7..1"
end

@testset "UniqueStrings" begin
    a = "foo"
    b = "bar"
    s = UniqueStrings()
    @test length(s) == 0
    @test isempty(s)
    push!(s, a)
    @test length(s) == 1
    @test !isempty(s)
    for _ in 1:9 push!(s, a) end
    for _ in 1:30 push!(s, b) end
    @test length(s) == 40
    @test repr(s) == """UniqueStrings{Int64}: 40 values
    bar => 30  (75.0%)
    foo => 10  (25.0%)
"""
end

@testset "MultipleSummaries" begin
    s = MultipleSummaries((UniqueStrings(), Extrema(Int)))
    s1 = UniqueStrings()
    s2 = Extrema(Int)
    @test length(s) == 0
    @test isempty(s)
    strings1 = ["foo", "bar", "baz"]
    for _ in 1:rand(100:200)
        x = rand(strings1)
        push!(s, 1, x)
        push!(s1, x)
    end
    # for _ in 1:rand(100:200)
    #     x = rand(1:10000)
    #     push!(s, 2, x)
    #     push!(s2, x)
    # end
    # @test length(s) == length(s1) + length(s2)
end
