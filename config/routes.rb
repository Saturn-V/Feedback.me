Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end
  
  root 'pages#landing'

  resources :pages, only: [:home,:landing]

  resources :classrooms, only: [:show, :new, :create] do
    resources :forms, only: [:index, :show, :new, :create]
  end
end
