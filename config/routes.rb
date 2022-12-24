Rails.application.routes.draw do
  devise_for :users
  scope :main do
    resources :users do 
      collection do 
        get :fetch_country_states
      end
    end
  end
  root 'home#index'
end
