class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|

      t.text :description
      t.decimal :amount
      t.date :date_issue

      t.references :person_id, index: true
      t.references :client_id, index: true

      t.timestamps null: false
    end

  end
end
