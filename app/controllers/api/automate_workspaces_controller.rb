module Api
# @resource AutomateWorkspace
# 
# This document describes the API for interacting with Automate Workspaces
#
# @authorize_with basic_http_auth
# 
  class AutomateWorkspacesController < BaseController
    # return a list of AutomateWorkspace
    # @summary Index of AutomateWorkspaces
    # @path [GET] /automate_workspaces
    # @response_type [Array<AutomateWorkspace>]
    def index
      klass = collection_class(@req.subject)
      res, subquery_count = collection_search(@req.subcollection?, @req.subject, klass)
      opts = {
        :name             => @req.subject,
        :is_subcollection => @req.subcollection?,
        :expand_actions   => true,
        :expand_resources => @req.expand?(:resources),
        :counts           => Api::QueryCounts.new(klass.count, res.count, subquery_count)
      }
      render_collection(:automate_workspaces, res, opts)
    end

    # return a AutomateWorkspace
    # @summary Fetch a AutomateWorkspace based on a guid
    # @path [GET] /automate_workspaces/{guid}
    # @response_type [AutomateWorkspace]
    # @parameter guid(required) [string] The guid of automate workspace
    def show
      obj = AutomateWorkspace.find_by(:guid => @req.c_id)
      if obj.nil?
        raise NotFoundError, "Invalid Workspace #{@req.c_id} specified"
      end
      render_resource(:automate_workspaces, obj)
    end

    # update a AutomateWorkspace
    # @summary Update an Automate Workspace based on a guid
    # @path [POST] /automate_workspaces/{guid}
    # @response_type [AutomateWorkspace]
    # @parameter guid(required) [string] The guid of automate workspace
    # @parameter data(required,body) [UpdateWorkspaceItem] The updated workspace
    def edit_resource(_type, id, data = {})
      obj = AutomateWorkspace.find_by(:guid => id)
      if obj.nil?
        raise NotFoundError, "Invalid Workspace #{id} specified"
      end
      obj.merge_output!(data)
    end
  end
end
