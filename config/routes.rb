Rails.application.routes.draw do

  resources :products do
    collection do
      post :delete_selected
      get :xml_import
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
