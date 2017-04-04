class API < Grape::API
  prefix "api"
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, ErrorFormatter

  mount API::V1
end
