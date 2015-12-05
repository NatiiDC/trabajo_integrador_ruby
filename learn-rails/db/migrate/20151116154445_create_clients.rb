class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstname
      t.string :lastname
      t.date :born
      t.string :type_document_cd
      t.integer :number_document
      t.integer :code

      t.timestamps null: false
    end
  end
end
