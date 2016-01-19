class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|

      t.string :contact

      t.references :client, index: true
      t.references :contact_type, index: true

      t.timestamps null: false
    end
  end
end
