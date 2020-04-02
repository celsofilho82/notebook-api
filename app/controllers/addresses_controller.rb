class AddressesController < ApplicationController
  before_action :set_address, only: [:show]

  # GET /address/1
 def show
   render json: @address
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_address
     if params[:contact_id]
       @address = Contact.find(params[:contact_id]).address
       return @address
     end
     @address = address.find(params[:id])
   end

   # Only allow a trusted parameter "white list" through.
   def address_params
     params.require(:address).permit(:id, :street, :city)
   end

end
