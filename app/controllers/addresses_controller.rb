class AddressesController < ApplicationController
  before_action :set_contact

  # DELETE /contact/1/address
  def destroy
    @contact.address.destroy
  end

  # POST /contact/1/address
  def create
    @contact.address = Address.new(address_params)

    if @contact.save
      render json: @contact.address, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end

  end

  # PATCH /contact/1/address
  def update
    if @contact.address.update(address_params)
      render json: @contact.address    
    else
      render json: @contact.errors, status: :unprocessable_entity
    end 
  end
 
  def show
   render json: @contact.address
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_contact
    @contact = Contact.find(params[:contact_id])
   end

   def address_params
    # Usando o active model serializer para deserializar o json recebido nas requisições
    # create e update
     ActiveModelSerializers::Deserialization.jsonapi_parse(params)
   end
   

end
