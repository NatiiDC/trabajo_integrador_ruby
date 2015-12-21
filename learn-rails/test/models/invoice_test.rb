require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

# La carga de una nueva factura emitida por un cliente:
#     Sin errores de validación
#     Con errores de validación

  test "Nuevas factura sin errores de validación" do
    invoices().each do |invoice|
      assert invoice.save
    end
  end

  test "Nueva factura con errores de validación" do

    assert_not Invoice.new(
    amount:" 123.5", date_issue:" 2014-5-21",
    client_id:" client1", person_id:" person1"
    ).save, "Guardando una factura sin descripción"

    assert_not Invoice.new(
    description: "Una descripcion cualquiera"
    date_issue:" 2014-5-21",
    client_id:" client1", person_id:" person1"
    ).save, "Guardando una factura sin monto"

    assert_not Invoice.new(
    description: "Una descripcion cualquiera"
    amount:" 123.5",
    client_id:" client1", person_id:" person1"
    ).save, "Guardando una factura sin el dia de facturación"

    assert_not Invoice.new(
    description: "Una descripcion cualquiera"
    amount:" 123.5", date_issue:" 2014-5-21",
    person_id:" person1"
    ).save, "Guardando una factura sin el id del cliente"

    assert_not Invoice.new(
    description: "Una descripcion cualquiera"
    amount:" 123.5", date_issue:" 2014-5-21",
    client_id:" client1",
    ).save, "Guardando una factura sin el id de la persona"

  end

end
