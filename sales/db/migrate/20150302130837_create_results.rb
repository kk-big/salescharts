class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :user_id
      t.string :result_ym
      t.string :result_date
      t.integer :negotiations
      t.integer :assessment
      t.integer :testdrive
      t.integer :newcar_new
      t.integer :newcar_replace
      t.integer :newcar_add
      t.integer :newcar_introduce
      t.integer :newcar_cash
      t.integer :newcar_credit
      t.integer :newcar_credit_re
      t.integer :registration_possible
      t.integer :registration_result
      t.integer :usedcar
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
    add_index :results, :user_id
    add_index :results, :result_ym
    add_index :results, :result_date
  end
end
