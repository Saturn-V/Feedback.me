Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    # Customized users/registrations routes
    get  'students/sign_up' => 'users/registrations#new_student', :as => 'new_student_registration'
    post 'students/sign_up' => 'users/registrations#create',     :as => 'student_registration'

    get  'instructors/sign_up' => 'users/registrations#new_instructor', :as => 'new_instructor_registration'
    post 'instructors/sign_up' => 'users/registrations#create',     :as => 'instructor_registration'
  end

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
