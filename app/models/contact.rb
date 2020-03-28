class Contact < ApplicationRecord
  
  belongs_to :kind, optional: true 
  has_many :phones, dependent: :destroy
  
  # Redefinindo o método as_json que é utilizado por debaixo dos panos pelo [render :json] no controller
  def as_json(options={})
    contact = super(
      except: [:created_at, :updated_at],
      include: {kind: { only: :description }}) # Fazendo a associação com o model kind
    contact[:birthdate] = I18n.l(self.birthdate) unless self.birthdate.blank? # Alterando a data para pt-br
    contact
  end
  
end
