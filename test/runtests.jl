using TextTableRows
using Base.Test

import TextTableRows: perc

@testset "perc" begin
    @test perc(pi) == "314.2%"
    @test perc(1/3) == "33.3%"
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
