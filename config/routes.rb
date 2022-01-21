Rails.application.routes.draw do

  resources :ebay_setups
  resources :etsy_setups
  resources :products do
    collection do
      post :delete_selected
      get :xml_import
      get :create_load_ebay_file
      get :create_etsy_products
      get '/:id/create_update_one_etsy', action: 'create_update_one_etsy', as: 'create_update_one_etsy'
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
