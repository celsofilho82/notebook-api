class PhonesController < ApplicationController
  before_action :set_phones, only: [:show]

   # GET /phones/1
  def show
    render json: @phones
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phones
      if params[:contact_id]
        @phones = Contact.find(params[:contact_id]).phones
        return @phones
      end
      @phones = phones.where(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def phones_params
      params.require(:phones).permit(:id, :number)
    end

end
