class Landing < ActiveRecord::Base
  self.abstract_class = true
  self.table_name = "landings"

  establish_connection(APP_CONFIG[:alli_db_connection])

  attr_accessible :bg_image, :main_heading, :sub_heading, :description, :title, :slug, :landing_type

  has_attached_file :bg_image, :default_url => "http://nicholasalli.s3.amazonaws.com/default_bg.jpg"
  validates_attachment_content_type :bg_image, :content_type => /\Aimage\/.*\Z/

  validates :title, :description, :slug, :main_heading, :sub_heading, presence: true
end
