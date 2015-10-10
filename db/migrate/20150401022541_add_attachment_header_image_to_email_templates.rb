class AddAttachmentHeaderImageToEmailTemplates < ActiveRecord::Migration
  def self.up
    change_table :email_templates do |t|
      t.attachment :header_image
    end
  end

  def self.down
    remove_attachment :email_templates, :header_image
  end
end
