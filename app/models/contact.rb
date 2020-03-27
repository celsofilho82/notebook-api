class Contact < ApplicationRecord
  belongs_to :kind
  
  def author
    "Celso Ribeiro"
  end
  
  # Redefinindo o método as_json que é utilizado por debaixo dos panos pelo [render :json] no controller
  def as_json(options={})
    super(root: true, except: [:created_at, :updated_at])
  end
  
end
