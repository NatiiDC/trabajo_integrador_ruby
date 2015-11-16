class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstname
      t.string :lastname
      t.date :born
      t.integer :document

      t.timestamps null: false
    end
  end
end
