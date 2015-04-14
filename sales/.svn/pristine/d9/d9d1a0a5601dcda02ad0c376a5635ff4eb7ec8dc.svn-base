class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :user_id
      t.string :plan_ym
      t.integer :customer
      t.integer :newcar
      t.integer :usedcar
      t.integer :onemonth
      t.integer :sixmonth
      t.integer :years
      t.integer :inspection
      t.integer :insurance

      t.timestamps null: false
    end
    add_index :plans, :user_id
    add_index :plans, :plan_ym
  end
end
