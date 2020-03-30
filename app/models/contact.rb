class Contact < ApplicationRecord
  belongs_to :kind, optional: true 
  # Fazendo associação has_one com address e nested para permitir criar um endereço na criação do contato
  has_one :address
  accepts_nested_attributes_for :address, update_only: true # Perminite somente atualizar o endereço
  # Fazendo associação has_many com phones e nested para permitir criar um telefone na criação do contato
  has_many :phones, dependent: :destroy
  accepts_nested_attributes_for :phones, allow_destroy: true
  
  
  # Redefinindo o método as_json que é utilizado por debaixo dos panos pelo [render :json] no controller
  def as_json(options={})
    contact = super(
      # Filtrando para não mostrar created_at e updated_at
      except: [:created_at, :updated_at],
      # Incluindo os models kind, phones e address no json de resposta
      include: {
        kind: { only: :description }, 
        phones: { only: [:id, :number] },
        address: { except: [:created_at, :updated_at] }   
        }
      ) 
    # Usando o I18n para alterar o formato da data para o padrão pt-BR  
    contact[:birthdate] = I18n.l(self.birthdate) unless self.birthdate.blank?
    contact
  end
  
end
