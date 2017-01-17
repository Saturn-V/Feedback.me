Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # JWT authentciation endpoint
  post 'auth_user' => 'authentication#authenticate_user'

  # Customized users/registrations routes
  devise_scope :user do
    get  'students/sign_up' => 'users/registrations#new_student', :as => 'new_student_registration'
    post 'students/sign_up' => 'users/registrations#create',     :as => 'student_registration'

    get  'instructors/sign_up' => 'users/registrations#new_instructor', :as => 'new_instructor_registration'
    post 'instructors/sign_up' => 'users/registrations#create',     :as => 'instructor_registration'
  end

  authenticated :user do
    root 'pages#home', as: :authenticated_root
  end

  # Default and Authenticated Root_Route's
  root 'pages#landing'


  # Customized classrooms routes
  get  'classrooms/join/search' => 'classrooms#join_classroom_search', :as => 'new_student_join_search'
  get  'classrooms/join' => 'classrooms#join_classroom', :as => 'new_student_join'

  # Classroom Routes with nested Forms Routes
  resources :classrooms, only: [:index, :show, :new, :create] do
    member do
      patch :join
      put :join
    end
    resources :forms, only: [:index, :show, :new, :create]

    post 'classrooms/:classroom_id/forms/:id/notifications' => 'notifications#create', :as => 'notification_creation'
  end

  # Notification routes
  resources :notifications, only: [:index]

  # Questions Routes
  resources :questions, only: [:create, :update, :destroy]

  # Pages Routes, for non model/RESTFUL related routes
  resources :pages, only: [:home,:landing]

  # Response routes
  resources :responses, only: [:edit, :update]



  namespace :api do
    namespace :v1 do
      resources :classrooms
    end
  end
end
