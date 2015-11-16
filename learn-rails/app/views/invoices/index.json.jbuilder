json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :client_id, :person_id, :description, :amount, :date_issue
  json.url invoice_url(invoice, format: :json)
end
