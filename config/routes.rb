Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
   resources :posts do
     resources :comments
     get '/add_to_favorite', to: 'posts#add_to_favorite'
   end


  root 'welcomes#welcome'

  get 'welcome', to: "welcomes#welcome"
  get 'feed', to: "welcomes#feed"
end
