using ArgCheck

import Base: length, push!, show, minimum, maximum, extrema, isempty

export Extrema, UniqueStrings, MultipleSummaries

mutable struct Extrema{T, S}
    count::T
    min::S
    max::S
end

Extrema(T,S) = Extrema{T,S}(zero(T), typemax(S), typemin(S))

Extrema(S) = Extrema(Int, S)

function push!(s::Extrema{T,S}, x::S) where {T,S}
    s.count += one(T)
    s.min = min(s.min, x)
    s.max = max(s.max, x)
    nothing
end

length(s::Extrema) = s.count

isempty(s::Extrema) = s.count == 0

function minimum(s::Extrema)
    @argcheck !isempty(s)
    s.min
end

function maximum(s::Extrema)
    @argcheck !isempty(s)
    s.max
end

function extrema(s::Extrema)
    @argcheck s.count > 0
    (s.min, s.max)
end

function show(io::IO, s::Extrema{T,S}) where {T,S}
    print(io, "Extrema{$(T),$(S)}: $(s.count) values")
    if s.count > 0
        print(io, ", $(s.min)..$(s.max)")
    end
end

struct UniqueStrings{T}
    dict::Dict{String,T}
end

UniqueStrings(T) = UniqueStrings(Dict{String,T}())

UniqueStrings() = UniqueStrings(Int)

function push!(s::UniqueStrings{T}, x::AbstractString) where T
    if haskey(s.dict, x)
        s.dict[x] += one(T)
    else
        s.dict[String(x)] = one(T)
    end
    nothing
end

length(s::UniqueStrings) = sum(values(s.dict))

isempty(s::UniqueStrings) = isempty(s.dict)

function show(io::IO, s::UniqueStrings{T}) where T
    len = length(s)
    println(io, "UniqueStrings{$(T)}: $(len) values")
    for (string, count) in sort(collect(s.dict), by = last, rev = true)
        println(io, "    $(string) => ", count_and_perc(count, len))
    end
end

struct MultipleSummaries{T <: Tuple}
    summaries::T
end

push!(s::MultipleSummaries, index::Int, x) = push!(s.summaries[index], x)

length(s::MultipleSummaries) = sum(length, s.summaries)

isempty(s::MultipleSummaries) = all(isempty, s.summaries)

function show(io::IO, s::MultipleSummaries)
    len = length(s)
    println(io, "MultipleSummaries{$(T)}: $(len) values")
    for summary in s.summaries
        count = length(summary)
        println(io, "    ", count_and_perc(count, len), " in ", summary)
    end
end
