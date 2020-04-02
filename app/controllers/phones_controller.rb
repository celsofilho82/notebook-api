class PhonesController < ApplicationController
  before_action :set_contact

  # DELETE /contact/1/phones
  def destroy
    phone = Phone.find(phone_params[:id])
    phone.destroy
  end

  # POST /contact/1/phone
  def create
    @contact.phones << Phone.new(phone_params)

    if @contact.save
      render json: @contact.phones, status: :created
    else
      render json: @contact.errors, status: :unprocessable_entity
    end

  end

  # PATCH /contact/1/phones
  def update
    phone = Phone.find(phone_params[:id])
    if phone.update(phone_params)
      render json: @contact.phones    
    else
      render json: @contact.errors, status: :unprocessable_entity
    end 
  end
 
  def show
   render json: @contact.phones
  end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_contact
    @contact = Contact.find(params[:contact_id])
   end

   def phone_params
    # Usando o active model serializer para deserializar o json recebido nas requisições
    # create e update
     ActiveModelSerializers::Deserialization.jsonapi_parse(params)
   end

end
