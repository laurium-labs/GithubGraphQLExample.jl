module GithubGraphQLExample

using HTTP
using JSON

include("generated/types.jl")

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
  T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)) )
end


macro gql_str(str::String)
  # str is the query to turn into a function call
  return str
end


function gql_query(query::String, T::Type, variables::Union{Nothing, NamedTuple}=nothing)::T
  body = Dict(
          "query" => query
      )

  if(!isnothing(variables))
    body["variables"] = JSON.json(variables)
  end

  r = HTTP.request(
      "POST",
      "https://api.github.com/graphql";
      headers=Dict("Authorization" => "Bearer $(ENV["github_access_token"])"),
      body=JSON.json(body)
  )

  body = String(r.body)

  dict = JSON.parse(body)

  res = parse_nt(T, dict["data"])

  return res
end


function get_companies()
  QUERY = gql"""query Companies {
    viewer {
      avatarUrl
      organizations(first: 10) {
        nodes {
          createdAt
          avatarUrl
          id
          name
          repositories(first: 10) {
            nodes {
              id
              issues {
                totalCount
              }
            }
          }
        }
      }
    }
  }
    
  """

  return gql_query(QUERY, CompaniesResult)
end


function get_current_user()

  QUERY = gql"""query CurrentUser($followers: Int!) {
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
      following(first: $followers) {
        nodes {
          avatarUrl
          bio
          company
          name
        }
      }
    }
  }  
  """

  return gql_query(QUERY, CurrentUserResult, CurrentUserVariables(10))

end


return get_current_user()

end # module
