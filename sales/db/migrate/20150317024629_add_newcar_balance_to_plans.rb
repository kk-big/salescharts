class AddNewcarBalanceToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :newcar_balance, :integer
  end
end
