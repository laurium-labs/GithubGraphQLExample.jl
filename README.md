# GithubGraphQLExample.jl

This repo is an example of consuming the GitHub GraphQL in Julia using auto-generated types. 

The following libraries are employed:
- https://github.com/laurium-labs/graphql-julia-codegen
- https://github.com/laurium-labs/GraphQLCodegen.jl

The JSON response from the server is automatically parsed into the auto-generated types. This is possible because GraphQL queries come back in a predictable format. 

You will need to set the env variable with `export github_access_token=YOUR_TOKEN_HERE`. A token can be generated from GitHub web ui (https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).

If you change a GraphQL query, you need to re-run code generation: `graphql-julia-codegen --localSchemaFile="./schema.json" --source="./src" --destination="./src/generated"`

If you do not have `graphql-julia-codegen` see https://github.com/laurium-labs/graphql-julia-codegen for install instructions.

## How to run

`julia --project`

```julia
julia> gh = include("src/GithubGraphQLExample.jl")
Main.GithubGraphQLExample

julia> user = gh.get_current_user()
```
