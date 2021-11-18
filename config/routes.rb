Rails.application.routes.draw do
  resources :tags
  resources :quotes
  delete 'quotes/' => 'quotes#destroy'
  
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
