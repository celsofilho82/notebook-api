class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    # Colocando [root] a raiz "contact" em cada elemento json [root: true]
    # Podemos fazer filtros mostrando somente algums dados na resposta only: [:name, :email] 
    # Adicionando uma nova informação com o método map [.map {|i| i.attributes.merge({author: "Celso"})}]
    # Podemos definir um método no model de chamar ele utilizando o simbolo :methods
    # Podemos também redefinir o método [as_json] no model
    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:name, :email, :birthdate)
    end
end