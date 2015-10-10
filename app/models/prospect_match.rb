class ProspectMatch < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "prospect_matches"

  establish_connection(APP_CONFIG[:alli_db_connection])

  validates :title, :city, presence: true
end
