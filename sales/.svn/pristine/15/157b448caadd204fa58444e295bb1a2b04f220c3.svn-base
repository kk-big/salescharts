class CreateProfits < ActiveRecord::Migration
  def change
    create_table :profits do |t|
      t.string :user_id
      t.string :profit_ym
      t.integer :number_of_newcar
      t.integer :sales_of_newcar
      t.integer :profit_of_newcar
      t.integer :number_of_usedcar
      t.integer :sales_of_usedcar
      t.integer :profit_of_usedcar
      t.integer :number_of_service
      t.integer :sales_of_service
      t.integer :profit_of_service

      t.timestamps null: false
    end
    add_index :profits, :user_id
    add_index :profits, :profit_ym
  end
end
