namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Recriando o database"
    %x(rails db:drop db:create db:migrate)
    puts "Database recriando com sucesso!!!"

    puts "Cadastrando os tipos de contato"
    kinds = %w(Amigo Comercial Conhecido Familia)
    kinds.each { |kind| Kind.create!(description: kind) }  
    puts "Tipos de contato cadastrados com sucesso!!!"
    
    puts "Cadastrando os contatos"
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        kind: Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso!!!"

    puts "Cadastrando os telefones"
    Contact.all.each do |contact|
      Random.rand(3).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact )
        contact.phones << phone
        contact.save!
      end
      
    end
    puts "Telefones cadastrados com sucesso!!!"

    puts "Cadastrando os endereços"
    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.full_address, 
        city: Faker::Address.city, 
        contact: contact)  
    end
    puts "Endereços cadastrados com sucesso!!!"

  end

end
