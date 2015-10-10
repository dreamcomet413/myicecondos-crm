class Favourite < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "favourites"

  establish_connection(APP_CONFIG[:alli_db_connection])
end
