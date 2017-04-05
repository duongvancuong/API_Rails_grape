class API::V1::CustomersAPI < Grape::API
  resources :customers do
    get do
      render_success 400, Settings.render_success,
        data: Article.all
    end
  end
end
