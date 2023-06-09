Rails.application.routes.draw do
  devise_for :users
  resources :recipe_foods
  resources :recipes do
    member do
      post 'toggle_public'
      get :new_food
    end
  end
  resources :foods
  resources :users
  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  get '/general_shopping_lists', to: 'recipe_foods#general_shopping_lists', as: 'general_shopping_lists'

  root 'foods#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
