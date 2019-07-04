Rails.application.routes.draw do
  root "static_pages#home"

  get "sessions/new"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/login", to: "sessions#create"

  post "/signup",  to: "users#create"

  delete "/logout", to: "sessions#destroy"

  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
