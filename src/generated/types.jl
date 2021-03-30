# @generated
# This file was automatically generated and should not be edited.

const CurrentUserResult_viewer_repositories_nodes = @NamedTuple begin
  createdAt::String
  id::String
  name::AbstractString
end

const CurrentUserResult_viewer_repositories = @NamedTuple begin
  nodes::Union{Nothing,Vector{Union{Nothing,CurrentUserResult_viewer_repositories_nodes}}}
end

const CurrentUserResult_viewer = @NamedTuple begin
  login::AbstractString
  name::Union{Nothing,AbstractString}
  avatarUrl::String
  repositories::CurrentUserResult_viewer_repositories
end

const CurrentUserResult = @NamedTuple begin
  viewer::CurrentUserResult_viewer
end
