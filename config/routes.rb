Rails.application.routes.draw do

  resources :ebay_setups
  resources :etsy_setups
  resources :products do
    collection do
      post :delete_selected
      get :xml_import
      get :create_load_ebay_file
    end
  end
  root to: 'visitors#index'
  devise_for :users, controllers: {
    registrations:  'users/registrations',
    sessions:       'users/sessions',
    passwords:      'users/passwords',
  }
  resources :users
end
