class API::V1::SessionApi < Grape::API
  resource :session_api do
    desc "Log in user"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post :login do
      user = User.find_by_email(params[:email].downcase)
      if user && user.authenticate(params[:password])
        auth_token = user.user_tokens.last.token
        render_success 200, Settings.render_success, auth_token: auth_token
      else
        error!('Unauthorized.', 401)
      end
    end
  end
end
