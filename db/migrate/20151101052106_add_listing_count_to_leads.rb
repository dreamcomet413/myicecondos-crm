class AddListingCountToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :viewed_listings_count, :integer
  end
end
