class Listing < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "listings"

  establish_connection(APP_CONFIG[:alli_db_connection])

  def self.get_listings data
    objects = []
    data.each do |d|
      o = Listing.where(id: d[1].to_i).first
      objects << o if o.present?
    end
    return objects
  end
end
