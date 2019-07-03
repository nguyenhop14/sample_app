Rails.application.routes.draw do
  root "static_pages#home"

  get "/signup", to: "users#new"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
