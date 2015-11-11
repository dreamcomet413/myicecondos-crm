class ListingImage < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "listing_images"

  establish_connection(APP_CONFIG[:icecondos_db_connection])

  def self.get_image_for_listing id
    ListingImage.where(imageable_id: id).first.try(:image_src)
  end
end
