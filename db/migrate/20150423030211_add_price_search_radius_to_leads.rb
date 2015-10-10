class AddPriceSearchRadiusToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :price_search_radius, :integer
  end
end
