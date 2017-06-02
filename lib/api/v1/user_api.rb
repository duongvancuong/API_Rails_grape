class API::V1::UserApi < Grape::API
  resource :user_api do
    desc "create new user"
    params do
      requires :user_name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post :create_new_user do
      user = User.new({
        user_name: params[:user_name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      })
      if user.save
        if user_tokens = user.user_tokens.generate
          render_success 200, Settings.render_success, auth_token: user_tokens.token
        else
          binding.pry
        end
      end
    end
  end
end
