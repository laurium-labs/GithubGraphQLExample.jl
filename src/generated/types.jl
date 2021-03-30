# @generated
# This file was automatically generated and should not be edited.


const CurrentUserVariables = @NamedTuple  begin
  followers::Int64
end


const CompaniesResult_viewer_organizations_nodes_repositories_nodes_issues = @NamedTuple begin
  totalCount::Int64
end

const CompaniesResult_viewer_organizations_nodes_repositories_nodes = @NamedTuple begin
  id::String
  issues::CompaniesResult_viewer_organizations_nodes_repositories_nodes_issues
end

const CompaniesResult_viewer_organizations_nodes_repositories = @NamedTuple begin
  nodes::Union{Nothing,Vector{Union{Nothing,CompaniesResult_viewer_organizations_nodes_repositories_nodes}}}
end

const CompaniesResult_viewer_organizations_nodes = @NamedTuple begin
  createdAt::String
  avatarUrl::String
  id::String
  name::Union{Nothing,AbstractString}
  repositories::CompaniesResult_viewer_organizations_nodes_repositories
end

const CompaniesResult_viewer_organizations = @NamedTuple begin
  nodes::Union{Nothing,Vector{Union{Nothing,CompaniesResult_viewer_organizations_nodes}}}
end

const CompaniesResult_viewer = @NamedTuple begin
  avatarUrl::String
  organizations::CompaniesResult_viewer_organizations
end

const CompaniesResult = @NamedTuple begin
  viewer::CompaniesResult_viewer
end

const CurrentUserResult_viewer_repositories_nodes = @NamedTuple begin
  createdAt::String
  id::String
  name::AbstractString
end

const CurrentUserResult_viewer_repositories = @NamedTuple begin
  nodes::Union{Nothing,Vector{Union{Nothing,CurrentUserResult_viewer_repositories_nodes}}}
end

const CurrentUserResult_viewer_following_nodes = @NamedTuple begin
  avatarUrl::String
  bio::Union{Nothing,AbstractString}
  company::Union{Nothing,AbstractString}
  name::Union{Nothing,AbstractString}
end

const CurrentUserResult_viewer_following = @NamedTuple begin
  nodes::Union{Nothing,Vector{Union{Nothing,CurrentUserResult_viewer_following_nodes}}}
end

const CurrentUserResult_viewer = @NamedTuple begin
  login::AbstractString
  name::Union{Nothing,AbstractString}
  avatarUrl::String
  repositories::CurrentUserResult_viewer_repositories
  following::CurrentUserResult_viewer_following
end

const CurrentUserResult = @NamedTuple begin
  viewer::CurrentUserResult_viewer
end
