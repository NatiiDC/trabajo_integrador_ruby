class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :client_id
      t.integer :person_id
      t.text :description
      t.decimal :amount
      t.date :date_issue

      t.timestamps null: false
    end
    add_index :invoices, :client_id
    add_index :invoices, :person_id
  end
end
