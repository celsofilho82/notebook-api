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

  it "GET /contacts/:id" do
    # Fazendo uma consulta no banco e pegando o primeiro contato e armazenando na variável
    contact = Contact.first
    # Enviando o cabeçalho da requisição 
    request.accept = 'application/json'
    # Fazendo um get na action show passando o id do contato pesquisado no banco
    get :show, params: {id: contact.id}
    # Pegando o corpo da resposta a requisição anterior e fazendo um parse no json
    response_body = JSON.parse(response.body)
    # Usando os dados parseados, usando o fetch para pegar o campo data e depois o id 
    # após comparando se o id recebido é o mesmo enviado
    expect(response_body.fetch('data').fetch('id')).to eq(contact.id.to_s)
  end
  
  
end
