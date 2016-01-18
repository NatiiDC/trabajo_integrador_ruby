class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|

      t.string :contact

      t.references :person, index: true
      t.references :type_contact, index: true

      t.timestamps null: false
    end
  end
end
