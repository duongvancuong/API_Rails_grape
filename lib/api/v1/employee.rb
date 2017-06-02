class API::V1::Employee < Grape::API
  resource :employee_data do
    desc "List all Employee"
    get :get_list_emp do
      authenticate!
      render_success 200, Settings.render_success, data: EmpDatum.all
    end

    desc "create new employee"
    params do
      requires :name, type: String
      requires :address, type: String
      requires :age, type: Integer
    end
    post :create_new_emp do
      authenticate!
      EmpDatum.create!({
        name: params[:name],
        address: params[:address],
        age: params[:age]
      })
    end

    desc "delete an employee"
    params do
      requires :id, type: String
    end
    delete ':id' do
      authenticate!
      EmpDatum.find(params[:id]).destroy!
    end

    desc "update an employee address"
    params do
      requires :id, type: String
      requires :address, type:String
      requires :age, type:Integer
    end
    put ':id' do
      authenticate!
      EmpDatum.find(params[:id]).update({
        address:params[:address], age:params[:age]
      })
    end
  end
end
