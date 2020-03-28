namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    p "Cadastrando os tipos de contato"
    kinds = %w(Amigo Comercial Conhecido Familia)
    kinds.each { |kind| Kind.create!(description: kind) }  
    p "Tipos de contato cadastrados com sucesso!!!"
    
    p "Cadastrando os contatos"
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        kind: Kind.all.sample
      )
    end
    p "Contatos cadastrados com sucesso!!!"

    p "Cadastrando os telefones"
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone, contact_id: contact.id )
        contact.phones << phone
        contact.save!
      end
      
    end
    p "Telefones cadastrados com sucesso!!!"

  end

end
