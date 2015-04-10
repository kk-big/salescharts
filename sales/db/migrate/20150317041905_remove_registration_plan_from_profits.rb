class RemoveRegistrationPlanFromProfits < ActiveRecord::Migration
  def change
    remove_column :profits, :registration_plan, :integer
  end
end
