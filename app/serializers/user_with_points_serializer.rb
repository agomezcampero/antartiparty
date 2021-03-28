class UserWithPointsSerializer < ActiveModel::Serializer
  attributes :id, :email, :points
end
