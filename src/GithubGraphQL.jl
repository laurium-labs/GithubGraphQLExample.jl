module GithubGraphQLExample

using HTTP
using JSON

const MyQueryResult_viewer = @NamedTuple begin
  login::AbstractString
end

const MyQueryResult = @NamedTuple begin
  viewer::MyQueryResult_viewer
end

function parse_nt(T::Type, s)::T
  s
end


function parse_nt(T::Type, d::Dict)::T
  T((parse_nt(fieldtype(T, t), d[String(t)]) for t in fieldnames(T)))
end



function get_current_user()

  MY_QUERY = """query MyQuery {
    viewer {
      login
    }
  }"""

  r = HTTP.request(
      "POST",
      "https://api.github.com/graphql";
      verbose=3,
      headers=Dict("Authorization" => "Bearer 766ce7a7504c2b3304ed591df5aaf62291a1ecaa"),
      body=JSON.json(Dict(
          "query" => MY_QUERY
  ))
  )

  dict = JSON.parse(String(r.body))

  res = parse_nt(MyQueryResult, dict["data"])

  login = res.viewer.login

  return res
end


get_current_user()




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
