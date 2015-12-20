def cuil_cuit(dni)
  cuilt = Faker::Number.number(2).to_s + '-' + dni + '-' + Faker::Number.number(1).to_s
end

#Creación de Personas con DNI de 8 dígitos

7.times do
  fullname = Faker::Name.name.split(' ')
  number_document = Faker::Number.number(8).to_s
  code = cuil_cuit(number_document)
  Client.create(
    firstname: fullname.first.truncate(25),
    lastname: fullname.last.truncate(25),
    born: Faker::Date.between(90.year.ago, 18.year.ago),
    type_document_cd: 'DNI',
    number_document: number_document,
    email: Faker::Internet.email,
    phone: '+54 221 ' + rand(4000000...7000000).to_s,
    address: Faker::Address.street_address,
    code: code
  )
end

#Creación de Personas con CI de 7 dígitos

2.times do
  fullname = Faker::Name.name.split(' ')
  number_document = Faker::Number.number(7).to_s
  code = cuil_cuit(number_document)
  Client.create(
    firstname: fullname.first.truncate(25),
    lastname: fullname.last.truncate(25),
    born: Faker::Date.between(90.year.ago, 18.year.ago),
    type_document_cd: 'CI',
    number_document: number_document,
    email: Faker::Internet.email,
    phone: '+54 221 ' + rand(4000000...7000000).to_s,
    address: Faker::Address.street_address,
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

30.times do
  Invoice.create(
    description: Faker::Lorem.sentence,
    amount: Faker::Number.decimal(2),
    date_issue: Faker::Date.between(5.year.ago, Date.today),
    client_id: Client.order('random()').limit(1).first.id,
    person_id: Person.order('random()').limit(1).first.id
  )
end
