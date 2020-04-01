class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate #:author
  has_one :address
  has_many :phones
  belongs_to :kind do
    link(:related) { kind_url(object.kind.id) } 
  end
    

  # Configurando a API para trabalhar com a especifiação JSONAPI HATEOAS
  # Esse configuração mostra o link para o documento que vai conter a json response
  # link(:self) { contact_path(object.id) }
  # link(:kind) { kind_path(object.kind.id) }

  # Código alterado para informar a url completa do recurso
  link(:self) { contact_url(object.id) }
  link(:kind) { kind_url(object.kind.id) }

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
