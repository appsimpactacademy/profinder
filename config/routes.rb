Rails.application.routes.draw do
  resources :users do 
    collection do 
      get :fetch_country_states
    end
  end
  devise_for :users
  root 'home#index'
end
