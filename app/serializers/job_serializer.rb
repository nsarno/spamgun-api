class JobSerializer < ActiveModel::Serializer
  attributes :id, :name, :status
end
