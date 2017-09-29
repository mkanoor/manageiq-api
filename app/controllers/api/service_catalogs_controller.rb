module Api
  # @resource Service Catalog
  #   
  # This document describes the API for interacting with Service catalog
  #
  # @authorize_with basic_http_auth

  class ServiceCatalogsController < BaseController
    include Subcollections::ServiceTemplates

    # return a ServiceCatalog
    # @summary Fetch a ServiceCatalog based on an id
    # @path [GET] /service_catalog/{id}
    # @response_type [Object]
    # @parameter id(required) [string] The id of service catalog
    def show
      super
    end
  end
end
