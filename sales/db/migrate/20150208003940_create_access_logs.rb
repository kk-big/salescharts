class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.timestamps :operation_time
      t.string :ip_address
      t.string :user_id
      t.text :url
      t.string :action
      t.text :parameters

      t.timestamps null: false
    end
  end
end
