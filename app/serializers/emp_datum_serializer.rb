class EmpDatumSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :age, :created_at, :updated_at
end
