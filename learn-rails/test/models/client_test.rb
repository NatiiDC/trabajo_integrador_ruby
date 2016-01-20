require 'test_helper'

class ClientTest < ActiveSupport::TestCase

  # La creación de un nuevo cliente:
  #     Con datos de contacto
  #     Con algún dato personal que no sea válido

  # El borrado de un cliente:
  #     Sin facturación registrada
  #     Con alguna factura emitida

  setup do
  	@client1 = clients(:client1)
  	@client2 = clients(:client2)
  	@client3 = clients(:client3)
  end

  test "No debería guardar un nuevo Cliente sin datos" do
    assert_not Client.new.save, "Guardando un cliente sin datos"
  end

  test "No debería guardar un cliente repetido" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",
      type_document_cd: "DNI",
      number_document: "38706162", code: "20-38706162-7",
      contacts_attributes: { "1" => {
        contact: "nataliaaparicio@gmail.com",
        contact_type_id: contact_types(:email).id}}
    ).save, "Guardando un cliente repetido"
  end

  test "No debería guardar un Cliente sin nombre ni apellido" do
    assert_not Client.new(
      born: "1995-5-21",type_document_cd: "DNI",
      number_document: "38706162", code: "20-38706162-7",
      contacts_attributes: { "1" => {
        contact: "+54-221-12345678",
        contact_type_id: contact_types(:mobile).id}}
    ).save, "Guardando un cliente sin nombre ni apellido"
  end

  test "No debería guardar un Cliente sin fecha de nacimiento" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio",
      type_document_cd: "DNI", number_document: "38706162",
      code: "20-38706162-7",
      contacts_attributes: { "1" => {
        contact: "+54-221-12345678",
        contact_type_id: contact_types(:mobile).id}})
    .save, "Guardando un cliente sin fecha de nacimiento"
  end

  test "No debería guardar un Cliente sin tipo documento" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio",
      born: "1995-5-21", number_document: "38706162",
      code: "20-38706162-7",
      contacts_attributes: { "1" => {
        contact: "+54-221-12345678",
        contact_type_id: contact_types(:mobile).id}})
      .save, "Guardando un cliente sin Documento"
  end


  test "No debería guardar un Cliente sin número documento" do
  assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",
    type_document_cd: "DNI", code: "20-38706162-7",
    contacts_attributes: { "1" => {
      contact: "+54-221-12345678",
      contact_type_id: contact_types(:mobile).id}})
  .save, "Guardando un cliente sin Documento"
  end


  test "No debería guardar un Cliente sin documento" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio",
      born: "1995-5-21", code: "20-38706162-7",
      contacts_attributes: { "1" => {
        contact: "+54-221-12345678",
        contact_type_id: contact_types(:mobile).id}})
    .save, "Guardando un cliente sin Documento"
  end

  test "No debería guardar un Cliente sin contactos" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",
      type_document_cd: "DNI", number_document: "38706162",
      code: "20-38706162-7").save, "Guardando un cliente sin dirección"
  end

  test "No debería guardar un Cliente sin CUIL o CUIT" do
    assert_not Client.new(
      firstname: "Natalia Elizabeth", lastname: "Aparicio",
      born: "1995-5-21", type_document_cd: "DNI",
      number_document: "38706162",
      contacts_attributes: { "1" => {
        contact: "+54-221-12345678",
        contact_type_id: contact_types(:mobile).id}})
    .save, "Guardando un cliente sin CUIL/CUIT"
  end

  test "No debería guardar un nuevo Cliente con datos válidos" do
      assert Client.new(
        firstname: "Pepe", lastname: "Flores",
        born: "1995-5-21", type_document_cd: "DNI",
        number_document: "41706162",
        contacts_attributes: { "1" => {
          contact: "+54-221-45345678",
          contact_type_id: contact_types(:mobile).id}},
        code: "20-41706162-7").save, "Cliente con datos validos"

  end

  test "Debería borrar un cliente sin facturas" do
    assert @client3.destroy
  end

  test "No debería borrar un cliente con factura/s" do
    assert_not @client1.destroy # Tiene una factura
    assert_not @client2.destroy # Tiene dos facturas
  end


end
