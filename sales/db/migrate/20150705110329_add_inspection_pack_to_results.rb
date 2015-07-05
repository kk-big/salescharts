class AddInspectionPackToResults < ActiveRecord::Migration
  def change
    add_column :results, :inspection_pack, :integer
  end
end
