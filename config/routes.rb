Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  root to: 'rooms#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
