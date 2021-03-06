class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
 
    # Essa implemetação deve ser utilizada caso a sua api tenha que seguir a especificação
    # json-api para paginação usando kaminari com acitve model serializer
    page_number = params[:page].try(:[], :number)
    per_page = params[:page].try(:[], :size)
    @contacts = Contact.all.page(page_number).per(per_page)
    render json: @contacts

    # Colocando [root] a raiz "contact" em cada elemento json [root: true]
    # Podemos fazer filtros mostrando somente algums dados na resposta only: [:name, :email] 
    # Adicionando uma nova informação com o método map [.map {|i| i.attributes.merge({author: "Celso"})}]
    # Podemos definir um método no model de chamar ele utilizando o simbolo :methods
    # Podemos também redefinir o método [as_json] no model
    
    # Substituir o render json pelo paginate para que a paginação aconteça através do header
    # paginate json: @contacts - usando kaminari com api-pagination
    # @contacts = Contact.all.page(params[:page])
  end

  # GET /contacts/1
  def show               # Incluindo o model kind na resposta e dicionando meta informação no json 
    render json: @contact, include: [:kind, :address, :phones], meta: { author: "Celso Ribeiro"}
  end

  # POST /contacts
  def create
    byebug
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
    #   params.require(:contact).permit(
    #     :name, :email, :birthdate, :kind_id, 
    #     phones_attributes: [:id, :number, :_destroy],
    #     address_attributes: [:id, :city, :street]
    #   )
      
      # Usando o active model serializer para deserializar o json recebido nas requisições
      # create e update
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
