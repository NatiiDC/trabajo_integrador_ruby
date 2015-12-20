class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|

      t.text :description
      t.decimal :amount
      t.date :date_issue

      t.references :person, index: true
      t.references :client, index: true

      t.timestamps null: false
    end

  end
end
