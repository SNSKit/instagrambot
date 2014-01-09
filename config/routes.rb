InstagramBot::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  
  root 'pages#index'  

  match '/about', :to => "pages#about", via: :get

  resources :users do
 	member do
 	  post :enable_following
 	end	
  end

  resources :hashtags do
    member do  
      post :create
    end
  end
end
