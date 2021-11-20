Rails.application.routes.draw do
  resources :users
  resources :tags
  resources :quotes
  delete 'quotes/' => 'quotes#destroy'
  post 'auth/sign-in' => 'auth#sign_in'
  post 'auth/sign-up' => 'auth#sign_up'
  
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
