# api/base/basev1.rb
class BaseApi < Grape::API
  format :json
  prefix :api

  mount BaseApi::V1::BaseV1
end

