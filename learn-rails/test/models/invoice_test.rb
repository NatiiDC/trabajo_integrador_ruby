require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

# La carga de una nueva factura emitida por un cliente:
#     Sin errores de validación
#     Con errores de validación

  setup do
    @invoice1 = invoices(:invoice1)
    @invoice2 = invoices(:invoice2)
    @invoice3 = invoices(:invoice3)
  end

  test "No debería guardar una factura sin descripción" do
    assert_not Invoice.new(
    amount: "123.5", date_issue: "2016-5-21",
    client_id: clients(:client1).id,
    person_id: people(:person1).id).save
  end

  test "No debería guardar una factura sin monto" do
    assert_not Invoice.new(
    description: "Una descripción cualquiera",
    date_issue: "2016-5-21",
    client_id: clients(:client1).id,
    person_id: people(:person1).id).save
  end

  test "No debería guardar una factura sin dia de facturación" do
    assert_not Invoice.new(
    description: "Una descripción cualquiera",
    amount: "123.5",
    client_id: clients(:client1).id,
    person_id: people(:person1).id).save
  end

  test "No debería guardar una factura sin el cliente" do
    assert_not Invoice.new(
    description: "Una descripción cualquiera",
    amount: "123.5", date_issue: "2016-5-21",
    person_id: people(:person1).id).save
  end

  test "No debería guardar una factura sin la personas" do
    assert_not Invoice.new(
    description: "Una descripción cualquiera",
    amount: "123.5", date_issue: "2016-5-21",
    client_id: clients(:client1).id).save
  end


  test "Deberia crear la factura con todos los datos" do
    assert Invoice.new(
    description: "Una descripción cualquiera",
    amount: "123.5", date_issue: "2016-5-21",
    client_id: clients(:client1).id,
    person_id: people(:person1).id).save
  end


end
