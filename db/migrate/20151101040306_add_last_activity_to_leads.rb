class AddLastActivityToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :last_activity_at, :datetime
  end
end
