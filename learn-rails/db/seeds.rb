def cuil_cuit(dni)
  cuilt = Faker::Number.number(2).to_s + '-' + dni + '-' + Faker::Number.number(1).to_s
end

# Creacion de Tipos de contactos y Contactos
def load_contact_types
  ContactType.create(name_cd: 'email')
  ContactType.create(name_cd: 'phone')
  ContactType.create(name_cd: 'mobile')
  ContactType.create(name_cd: 'address')
end

def load_contacts

  1.upto(5) { |id|
    Contact.create(
      contact: '+54 221 ' + rand(4000000...7000000).to_s,
      client_id: id,
      contact_type_id: ContactType.where(name_cd: "phone").first.id
    )
  }

  1.upto(5) { |id|
    Contact.create(
      contact: '+54 221 ' + rand(4000000...7000000).to_s,
      client_id: id,
      contact_type_id: ContactType.where(name_cd: "mobile").first.id
    )
  }

  1.upto(5) { |id|
    Contact.create(
      contact: Faker::Address.street_address,
      client_id: id,
      contact_type_id: ContactType.where(name_cd: "address").first.id
    )
  }

  1.upto(5) { |id|
    Contact.create(
    contact: Faker::Internet.email,
    client_id: id,
    contact_type_id: ContactType.where(name_cd: "email").first.id
    )
  }
end

# Creación de Personas
def load_people
  12.times do
    Person.create(
    name: (Faker::Name.name).truncate(25),
    code: cuil_cuit(Faker::Number.number(8).to_s)
    )
  end
end

# Creación de Clientes
def load_clients
  5.times do |i|
    fullname = Faker::Name.name.split(' ')
    number_document = Faker::Number.number(8).to_s
    code = cuil_cuit(number_document)
    Client.create(
      firstname: fullname.first.truncate(25),
      lastname: fullname.last.truncate(25),
      born: Faker::Date.between(60.year.ago, 18.year.ago),
      type_document_cd: ['DNI', 'CI', 'LD'].shuffle.first,
      number_document: number_document,
      code: code,
      contacts_attributes: {i.to_s => {
        contact: Faker::Internet.email,
        client_id: i,
        contact_type_id: ContactType.where(name_cd: "email").first.id}}
    )
  end
end

# Creación de Facturas
def load_invoices
  100.times do
    Invoice.create(
      description: Faker::Lorem.sentence,
      amount: Faker::Number.decimal(2),
      date_issue: Faker::Date.between(1.year.ago, Date.today),
      person_id: Person.order('random()').limit(1).first.id,
      client_id: Client.order('random()').limit(1).first.id
    )
  end


end

load_contact_types
load_contacts
load_people
load_clients
load_invoices
