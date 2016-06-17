class SetDefaultLeadStatus < ActiveRecord::Migration
  def up
    change_column_default(:leads, :status, "new")
  end

  def down
  end
end
