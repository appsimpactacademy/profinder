Rails.application.routes.draw do
  devise_for :users
  resources :users do 
    collection do 
      get :fetch_country_states
    end
  end
  root 'home#index'
end
