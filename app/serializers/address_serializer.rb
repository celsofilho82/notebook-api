class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city
  belongs_to :contact
end
