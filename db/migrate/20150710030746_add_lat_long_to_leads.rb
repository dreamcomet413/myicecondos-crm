class AddLatLongToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :lat, :float
    add_column :leads, :long, :float
  end
end
