class AddRegistrationPlanUpdateToResults < ActiveRecord::Migration
  def change
    add_column :results, :registration_plan_update, :integer
  end
end
