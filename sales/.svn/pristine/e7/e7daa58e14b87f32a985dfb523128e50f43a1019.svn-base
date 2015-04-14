class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_password
      t.string :user_name
      t.integer :emp_no
      t.string :position
      t.string :job
      t.string :role
      t.integer :display_order
      t.string :delete_flag

      t.timestamps null: false
    end
  end
end
