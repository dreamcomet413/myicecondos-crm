class SiteUser < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "users"

  establish_connection(APP_CONFIG[:alli_db_connection])

  def favourites
    Favourite.where(user_id: id)
  end

  def prospect_matches
    ProspectMatch.where(user_id: id)
  end
end
