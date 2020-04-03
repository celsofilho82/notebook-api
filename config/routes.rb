Rails.application.routes.draw do
  # Rota criada para gerar tokens JWT para os usuários da aplicação
  resources :auths, only: [:create]
  
  resources :kinds
  resources :contacts do
    # Rotas aninhadas no singular a ação de mostrar o recurso passa a ser do show e não do index.
    resource :kind, only: [:show]
    resource :kind, only: [:show], path: 'relationships/kind'

    resource :phones, only: [:show]
    resource :phones, only: [:show], path: 'relationships/phones'

    # Recurso para criar um telefone(singular) por vez
    resource :phone, only: [:update, :create, :destroy]
    resource :phone, only: [:update, :create, :destroy], path: 'relationships/phones'

    resource :address, only: [:show, :update, :create, :destroy]
    resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
