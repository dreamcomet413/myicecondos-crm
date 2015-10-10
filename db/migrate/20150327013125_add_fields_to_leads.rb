class AddFieldsToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :buying_info_owns, :string
    add_column :leads, :buying_info_planning, :string
    add_column :leads, :buying_info_price_from, :float
    add_column :leads, :buying_info_price_to, :float
    add_column :leads, :buying_info_property_type, :string
    add_column :leads, :buying_info_construction_type, :string
    add_column :leads, :buying_info_bedrooms, :string
    add_column :leads, :buying_info_bathrooms, :string
    add_column :leads, :buying_info_interest, :string
    add_column :leads, :buying_info_city, :string
    add_column :leads, :buying_info_mortgage, :string
    add_column :leads, :buying_info_garage, :string
    add_column :leads, :listing_info_property_type, :string
    add_column :leads, :listing_info_address, :string
    add_column :leads, :listing_info_property_condition, :string
    add_column :leads, :listing_info_city, :string
    add_column :leads, :listing_info_parking_type, :string
    add_column :leads, :listing_info_postal_code, :string
    add_column :leads, :listing_info_basement, :string
    add_column :leads, :listing_info_lead_is, :string
    add_column :leads, :listing_info_status, :string
    add_column :leads, :listing_info_bedrooms, :string
    add_column :leads, :listing_info_bathrooms, :string
    add_column :leads, :listing_info_sell_in, :string
  end
end
