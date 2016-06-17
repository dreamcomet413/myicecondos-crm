class AddUserIdToEmailTemplates < ActiveRecord::Migration
  def change
    add_column :email_templates, :user_id, :integer
  end
end
