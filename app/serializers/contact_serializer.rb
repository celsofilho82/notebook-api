class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  def attributes(*args)
    contact = super(*args)
    # pt-BR --> contact[:birthdate] = I18n.l(object.birthdate) unless object.birthdate.blank?
    contact[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    contact
  end
  
end
