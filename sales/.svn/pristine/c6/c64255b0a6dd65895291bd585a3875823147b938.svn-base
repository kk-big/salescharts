class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :user_id
      t.string :inspection_ym
      t.integer :onemonth
      t.integer :sixmonth
      t.integer :years
      t.integer :years_not
      t.integer :inspection
      t.integer :inspection_not
      t.integer :insurance_new
      t.integer :insurance_renew
      t.integer :insurance_cancel

      t.timestamps null: false
    end
    add_index :inspections, :user_id
    add_index :inspections, :inspection_ym
  end
end
