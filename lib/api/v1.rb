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

    def render_error_authenticate status_code, message
      {
        Settings.meta => {
          Settings.status_code => status_code,
          Settings.message => message
        }
      }
    end

    def authenticate!
      error!("401 Unauthorized", 401) unless current_user
    end

    def current_user
      # find token. Check if valid.
      token = UserToken.where(token: http_auth_header).first
      if token && !token.expired?
        @current_user = User.find_by_id(token.user_id)
      else
        false
      end
    end

    def http_auth_header
      if request.headers['Authorization'].present?
        return request.headers['Authorization'].split(' ').last
      end
    end
  end

  # add_swagger_documentation api_version: "v1",
  #                           hide_documentation_path: true,
  #                           mount_path: "/api/v1/swagger_doc",
  #                           hide_format: true

  mount Employee
  mount UserApi
  mount SessionApi
  # mount UserToken
  # mount User
end
