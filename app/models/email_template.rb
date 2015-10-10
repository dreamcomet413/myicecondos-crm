class EmailTemplate < ActiveRecord::Base
  attr_accessible :body, :subject, :title, :header_image

  has_attached_file :header_image
  validates_attachment_content_type :header_image, :content_type => /\Aimage\/.*\Z/

  validates :title, :subject, :body, presence: true
  belongs_to :user
end
