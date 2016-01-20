class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|

      t.string :name_cd

      t.timestamps null: false
    end
  end
end
