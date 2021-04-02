module GithubGraphQLExample

using HTTP
using JSON
using GraphQLCodegen

include("generated/Companies.jl")
include("generated/CurrentUser.jl")

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
      headers=Dict("Authorization" => "Bearer $(ENV["github_access_token"])", "Content-Type" => "application/json"),
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

  res = gql_query(QUERY, CurrentUserResult, CurrentUserVariables(10))

  return res

end

end # module
