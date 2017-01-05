Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end

  # Create a custom route that contains classroom ID for signup of students

  root 'pages#landing'

  resources :pages, only: [:home,:landing]

  resources :classrooms, only: [:show, :new, :create] do
    resources :forms, only: [:index, :show, :new, :create]
  end
end
