Rails.application.routes.draw do
  resources :users do
    member do
      get :send_user_messages
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
