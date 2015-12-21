require 'test_helper'

class ClientTest < ActiveSupport::TestCase

# La creación de un nuevo cliente:
#     Con datos de contacto
#     Con algún dato personal que no sea válido

# El borrado de un cliente:
#     Sin facturación registrada
#     Con alguna factura emitida


  def setup
    @clientWithInvoices = clients(:client1)
    @clientWithOutInvoices = clients(:clientWithOutInvoices)
  end


  test "Creacion de un nuevo Cliente sin algunos datos datos" do
    assert_not Client.new.save, "Guardando un cliente sin datos"
  end

  test "Creacion de un Cliente repetido" do
    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente repetido"
  end

  test "Creacion de un nuevo Cliente con datos invalidos o sin todos los datos requeridos" do

    assert_not Client.new(
    born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente sin nombre ni apellido"

    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente sin fecha de nacimiento"

    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",
    email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente sin Documento"

    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente sin email"

    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    code: "20-38706162-7").save, "Guardando un cliente sin dirección"

    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234").save, "Guardando un cliente sin CUIL/CUIT"

  end

  test "Creacion de un nuevo Cliente con datos validos" do
    obj =  Client.new(
      firstname: "Sara", lastname: "Kay", born: "1915-5-21", type_document_cd: "DNI",
      number_document: "8706162", email: "sarakay@ejemplo.com",
      address: "en algun lugar", code: "20-44321123-9"
    )
    assert obj.save, "Guardando un cliente con datos validos sin telefono"

    assert Client.new(
    firstname: "Sarasa", lastname: "Tomate", born: "1915-5-21", type_document_cd: "LD",
    number_document: "8706162", email: "sarasat@ejemplo.com",phone: "+54-221-8374931",
    address: "en algun lugar", code: "20-12312134-8").save, "Guardando un cliente con datos validos con telefono"

  end

  test "Borrado de un cliente sin facturas" do
    assert @clientWithOutInvoices.destroy(), "Borrando cliente sin facturas."
  end

  test "Borrado con un cliente con facturas" do
    assert_not @clientWithInvoices.destroy(), "Borrando cliente con facturas."
  end

end
