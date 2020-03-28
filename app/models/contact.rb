class Contact < ApplicationRecord
  belongs_to :kind, optional: true 
  
  has_one :address
  accepts_nested_attributes_for :address

  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
  
  
  # Redefinindo o método as_json que é utilizado por debaixo dos panos pelo [render :json] no controller
  def as_json(options={})
    contact = super(
      # Filtrando para não mostrar created_at e updated_at
      except: [:created_at, :updated_at],
      # Fazendo a associação com o model kind e phones
      include: {kind: { only: :description }, phones: { only: [:id, :number] }}
      ) 
    # Usando o I18n para alterar o formato da data para o padrão pt-BR  
    contact[:birthdate] = I18n.l(self.birthdate) unless self.birthdate.blank?
    contact
  end
  
end
