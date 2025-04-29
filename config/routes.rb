Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resource :posts
  root "posts#index"

  resources:user_monsters, only: [:new, :create, :index]

  resources :users do
    resources :monster_messages, only: [:index, :create], path: 'monsters/:conversation_id/messages'
  end
end
