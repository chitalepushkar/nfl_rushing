Rails.application.routes.draw do
  resources :rushing_statistics, defaults: {format: :json}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
