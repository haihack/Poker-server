Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     resources :cards, only: [:create]
      mount BaseApi => '/'
  #   end
  # end
end
