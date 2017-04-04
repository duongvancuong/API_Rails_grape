class API::V1 < Grape::API
  version "v1", using: :path

  rescue_from Grape::Exceptions::ValidationErrors do
    error!({status_code: Settings.http_code.code_400, content: Settings.validations_error},
      Settings.http_code.code_200)
  end

  desc "Return the current API version - V1."
  get do
    {version: "v1"}
  end

  helpers do
    def render_success status_code, message, data = {}
      {
        Settings.meta => {
          Settings.string_success => Settings.success,
          Settings.status_code => status_code,
          Settings.message => message
        }.merge(data)
      }
    end
  end

  mount CustomersAPI
end
