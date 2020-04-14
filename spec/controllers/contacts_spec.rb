require 'rails_helper'

# O primeiro passo é descrever uma classe(a classe que você vai testar)
describe ContactsController, type: :controller do
  # Primeiro teste é testar o código de status http na index do controller
  it "request index and return 200 OK [method: eql(200)]" do
    request.accept = 'application/json'
    get :index
    expect(response.status).to eql(200)   
  end

  # Realizando o mesmo teste acima só que usando um outro método do RSPEC
  it "request index and return 200 OK [method: have_http_status(200)]" do
    request.accept = 'application/json'
    get :index
    expect(response).to have_http_status(200)   
  end

  # Testando se o status code é 406 quando não é enviado o header accept: application/json
  it "request index and return 406 when accept application/json not present " do
    get :index
    expect(response).to have_http_status(406)   
  end
  
end
