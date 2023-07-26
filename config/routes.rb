Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get "excluir/:id", to: "home#excluir"
  get "adicionar", to: "home#adicionar"
  post "adicionar", to: "home#cadastrar"

  get "api/caixas", to: "api#index"
  delete "api/caixas/:id", to: "api#excluir"
  post "api/caixas", to: "api#cadastrar"
end
