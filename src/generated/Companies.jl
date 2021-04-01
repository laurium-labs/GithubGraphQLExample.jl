# @generated
# This file was automatically generated and should not be edited.

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
