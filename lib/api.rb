require "grape-swagger"

class API < Grape::API
  prefix "api"
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, ErrorFormatter

  mount API::V1

  add_swagger_documentation api_version: "v1",
                            hide_documentation_path: true,
                            mount_path: "/api/v1/swagger_doc",
                            hide_format: true
end
