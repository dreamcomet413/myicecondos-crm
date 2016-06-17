class CreateCampaignEmails < ActiveRecord::Migration
  def change
    create_table :campaign_emails do |t|
      t.integer :campaign_id
      t.integer :email_template_id
      t.integer :send_in_minutes

      t.timestamps
    end
  end
end
