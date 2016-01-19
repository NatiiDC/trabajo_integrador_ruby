def cuil_cuit(dni)
  cuilt = Faker::Number.number(2).to_s + '-' + dni + '-' + Faker::Number.number(1).to_s
end

#Creación de Clientes con CI de 7 dígitos

3.times do
  fullname = Faker::Name.name.split(' ')
  number_document = Faker::Number.number(8).to_s
  code = cuil_cuit(number_document)
  Client.create(
    firstname: fullname.first.truncate(25),
    lastname: fullname.last.truncate(25),
    born: Faker::Date.between(90.year.ago, 18.year.ago),
    type_document_cd: 'CI',
    number_document: number_document,
    code: code
  )
end

#Creación de Clientes con DNI de 8 dígitos

6.times do
  fullname = Faker::Name.name.split(' ')
  number_document = Faker::Number.number(8).to_s
  code = cuil_cuit(number_document)
  Client.create(
    firstname: fullname.first.truncate(25),
    lastname: fullname.last.truncate(25),
    born: Faker::Date.between(90.year.ago, 18.year.ago),
    type_document_cd: 'DNI',
    number_document: number_document,
    code: code
  )
end


# Creación de Personas

10.times do
  Person.create(
    name: (Faker::Name.name).truncate(25),
    code: cuil_cuit(Faker::Number.number(8).to_s)
  )
end

#Creación de Facturas

40.times do
  Invoice.create(
    description: Faker::Lorem.sentence,
    amount: Faker::Number.decimal(2),
    date_issue: Faker::Date.between(5.year.ago, Date.today),
    client_id: Client.order('random()').limit(1).first.id,
    person_id: Person.order('random()').limit(1).first.id
  )
end

ContactType.create(name_cd: 'email')
ContactType.create(name_cd: 'phone')
ContactType.create(name_cd: 'mobile')
ContactType.create(name_cd: 'address')

1.upto(8) { |id|
  Contact.create(
    contact: Faker::Internet.email,
    client_id: id,
    contact_type_id: ContactType.where(name_cd: "email").first.id
  )
}

1.upto(8) { |id|
  Contact.create(
    contact: '+54 221 ' + rand(4000000...7000000).to_s,
    client_id: id,
    contact_type_id: ContactType.where(name_cd: "phone").first.id
  )
}

1.upto(8) { |id|
  Contact.create(
    contact: '+54 221 ' + rand(4000000...7000000).to_s,
    client_id: id,
    contact_type_id: ContactType.where(name_cd: "mobile").first.id
  )
}

1.upto(8) { |id|
  Contact.create(
    contact: Faker::Address.street_address,
    client_id: id,
    contact_type_id: ContactType.where(name_cd: "address").first.id
  )
}
