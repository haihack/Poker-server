module V1::Entities
  class HandCheckingEntity < Grape::Entity
    expose :id
    expose :name
    expose :quantity
    expose :price
  end
end
