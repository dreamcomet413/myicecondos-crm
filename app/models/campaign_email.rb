class CampaignEmail < ActiveRecord::Base
  attr_accessible :campaign_id, :email_template_id, :send_in_minutes
  belongs_to :campaign
  belongs_to :email_template

  validates :send_in_minutes, :email_template_id, presence: true

  def send_and_record lead, run_at
    UserMailer.delay(run_at: run_at).campaign_email(lead, email_template)
  end
end
