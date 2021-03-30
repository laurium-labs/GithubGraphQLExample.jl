using JSON
const Members = @NamedTuple begin
    users::String
end

const Repos = @NamedTuple begin
    groups::Union{Vector{Members}, Nothing}
end

function parse_nt(T::Any, s)::T
    s
end

function parse_nt(::Type{Union{T2, Nothing}}, vec::Vector) where T2
    [map(v -> parse_nt(eltype(T2), v), vec)...]
end


function parse_nt(T::Type, d::Dict)::T
    T((parse_nt(fieldtype(T, t), d[String(t)]) for t in fieldnames(T)))
end

function parse_nt(::Type{Union{T, Nothing}}, d::Dict) where {T} 
    (!haskey(d, String(T)) ? nothing : parse_nt(T, d))
end

# d = JSON.parse("""{"groups": [{"users": "mark"}]}""")

# parse_nt(Repos, d)

d = JSON.parse("""{"groups": [{"users": "mark"}]}""")

parse_nt(Repos, d)
