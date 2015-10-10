class AddRequestedInfoToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :requested_info, :text
  end
end
