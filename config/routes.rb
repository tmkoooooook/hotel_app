Rails.application.routes.draw do
  devise_for :users,
  :skip => [:registrations]
  devise_scope :user do
      get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
      patch 'profile_edit', to: 'users/registrations#profile_update', as: 'profile_update'
      get "user/sign_up", to: "users/registrations#new", as: :new_user_registration
      post "user/sign_up", to: "users/registrations#create", as: :user_registration
      get "user/edit", to: "users/registrations#edit", as: :edit_user_registration
      put "user/edit", to: "users/registrations#update",as: :update_user_registration
  end
  root to: 'rooms#index'
  get 'users/account', to: 'users#show'
  get 'rooms/posts', to: 'rooms#posts'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only:[:show, :edit, :update]
  resources :reservations
  resources :rooms do
      get :search, on: :collection
  end
end
