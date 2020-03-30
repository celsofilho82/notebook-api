class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate #:author
  belongs_to :kind
  has_one :address
  has_many :phones

  # Informações extras no json, "atributo virtual"
  # def author
  #   "Celso Ribeiro"
  # end
  
  # Inserindo informação de metadados em todas as actions do controller
  # meta do
  #   { author: "Celso Ribeiro" }
  # end

  def attributes(*args)
    contact = super(*args)
    # pt-BR --> contact[:birthdate] = I18n.l(object.birthdate) unless object.birthdate.blank?
    contact[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    contact
  end
  
end
