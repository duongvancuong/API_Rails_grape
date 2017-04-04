class API::V1::CustomersAPI < Grape::API
  resources :customers do
    get do
      render_success 0
    end
  end
end
