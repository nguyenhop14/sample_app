Rails.application.routes.draw do
  root "static_pages#home"

  get "users/new", to: "users#new"
  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "users#new"

  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
