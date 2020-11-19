module V1
  class BaseV1 < Grape::API
    mount V1::HandChecking
  end
end
