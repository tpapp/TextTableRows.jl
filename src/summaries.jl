using ArgCheck

import Base: length, push!, show, minimum, maximum, extrema, isempty

export Extrema, UniqueStrings

mutable struct Extrema{T, S}
    count::T
    min::S
    max::S
end

Extrema(T,S) = Extrema{T,S}(zero(T), typemax(S), typemin(S))

Extrema(S) = Extrema(Int, S)

function push!{T,S}(s::Extrema{T,S}, x::S)
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

function show{T,S}(io::IO, s::Extrema{T,S})
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

function push!{T}(s::UniqueStrings{T}, x::AbstractString)
    if haskey(s.dict, x)
        s.dict[x] += one(T)
    else
        s.dict[String(x)] = one(T)
    end
    nothing
end

length(s::UniqueStrings) = sum(values(s.dict))

isempty(s::UniqueStrings) = isempty(s.dict)

function show{T}(io::IO, s::UniqueStrings{T})
    len = length(s)
    println(io, "UniqueStrings{$(T)}: $(len) values")
    for (string, count) in sort(collect(s.dict), by = last, rev = true)
        println(io, "    $(string) => $(count)  ($(perc(count/len)))")
    end
end
