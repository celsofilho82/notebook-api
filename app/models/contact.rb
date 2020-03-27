class Contact < ApplicationRecord
  belongs_to :kind

  def author
    "Celso Ribeiro"
  end
  
  def kind_description
    self.kind.description
  end
  

  # Redefinindo o método as_json que é utilizado por debaixo dos panos pelo [render :json] no controller
  def as_json(options={})
    super(
      except: [:created_at, :updated_at],
      methods: :kind_description, # Chamando o método que vai gerar no json a descrição do tipo
      include: {kind: { only: :description }}, # Fazendo a associação com o model kind
    )
  end
  
end
