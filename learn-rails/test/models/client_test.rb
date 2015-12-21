require 'test_helper'

class ClientTest < ActiveSupport::TestCase

# La creación de un nuevo cliente:
#     Con datos de contacto
#     Con algún dato personal que no sea válido

# El borrado de un cliente:
#     Sin facturación registrada
#     Con alguna factura emitida


  test "Creacion de un nuevo Cliente sin algunos datos datos" do
    assert_not Client.new.save, "Guardando un cliente sin datos"
  end

  test "Creacion de un Cliente repetido" do
    assert_not Client.new(
    firstname: "Natalia Elizabeth", lastname: "Aparicio", born: "1995-5-21",type_document_cd: "DNI",
    number_document: "38706162", email: "nataliaa@ejemplo.com", phone: "+54-221-12345678",
    address: "520 nro.1234", code: "20-38706162-7").save, "Guardando un cliente repetido"
  end

  test "Creacion de un nuevo Cliente con datos inválidos o sin todos los datos requeridos" do

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

  test "Creacion de un nuevo Cliente con datos válidos" do

    Client.all.each do |cl|
      if (! cl.phone.nil?)
        assert cl.save, "Guardando un cliente con datos válidos con telefono"
      else
        assert cl.save, "Guardando un cliente con datos válidos sin telefono"
      end
    end

  end

  test "Borrando clientes" do
      Client.all.each do |cl|
        if (cl.invoices.count == 0)
          assert cl.destroy(), "Cliente sin facturas"
        else
          assert_not cl.destroy(), "Cliente con factura/s"
        end
      end
    end

end
