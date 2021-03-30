module GithubGraphQLExample

using HTTP
using JSON

include("generated/types.jl")

function parse_nt(T::Any, s)::T
  s
end

function parse_nt(::Type{Union{T2, Nothing}}, vec::Vector) where T2
  @info "parsing vector"

  [map(v -> parse_nt(eltype(T2), v), vec)...]
end


function parse_nt(T::Type, d::Dict)::T
  @info "parsing dict without union"

  T((parse_nt(fieldtype(T, t), d[String(t)]) for t in fieldnames(T)))
end

function parse_nt(::Type{Union{T, Nothing}}, d::Dict) where {T} 
  @info "parsing dict"
  @info T
  T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)) )
end



# function parse_nt(T::Any, d::Dict)::T
#   @info d
#   T((parse_nt(fieldtype(T, t), d[String(t)]) for t in fieldnames(T)))
# end


macro gql_str(str::String)
  # str is the query to turn into a function call
  return str
end


function get_current_user()

  MY_QUERY = gql"""query CurrentUser {
    viewer {
      login
      name
      repositories(first: 10) {
        nodes {
          createdAt
          id
          name
        }
      }
      avatarUrl
    }
  }
  
  """

  r = HTTP.request(
      "POST",
      "https://api.github.com/graphql";
      headers=Dict("Authorization" => "Bearer 766ce7a7504c2b3304ed591df5aaf62291a1ecaa"),
      body=JSON.json(Dict(
          "query" => MY_QUERY
      ))
  )

  body = String(r.body)

  @info body

  dict = JSON.parse(body)

  res = parse_nt(CurrentUserResult, dict["data"])

  login = res.viewer.login

  return res
end


return get_current_user()




# Parse result into code-generated type.

# parse_to_nt = function(T, d)
#   @info "hi"
#   T((parse_to_nt(fieldtype(T, t), d[String(t)]) for t in fieldnames(T)))
# end

# parse_to_nt = function(T::Type, d::AbstractString)
#   d
# end

# dict = JSON.parse(String(r.body))

# res = parse_to_nt(MyQueryResult, dict)

# @info "here"

# return res


end # module
