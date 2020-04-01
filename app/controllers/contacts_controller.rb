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
  def show               # Incluindo o model kind na resposta e dicionando meta informação no json 
    render json: @contact, include: [:kind, :address, :phones], meta: { author: "Celso Ribeiro"}
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
      params.require(:contact).permit(
        :name, :email, :birthdate, :kind_id, 
        phones_attributes: [:id, :number, :_destroy],
        address_attributes: [:id, :city, :street]
      )
    end
end
