class AuthsController < ApplicationController
  # Controller criado somente para gerar tokens JWT para os usuários da aplicação

  # Metódo criado para gerar um token de authenticação usando jwt
  def create
    payload = params[:name]
    # Neste exemplo gerando um token que só vale por 30s 
    # payload = { name: params[:name], exp: Time.now.to_i + 30 }
    hmac_secret = 'my$ecretK3y'
    token = JWT.encode payload, hmac_secret, 'HS256'
    render json: { token: token } # Devolvo o token para o usuário
  end
  
end
