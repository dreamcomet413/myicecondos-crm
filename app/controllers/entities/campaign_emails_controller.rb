class CampaignEmailsController < ApplicationController
  before_filter :load_campaign

  def create
    @camp_email = @campaign.campaign_emails.create params[:campaign_email]
  end

  def update
    @camp_email = @campaign.campaign_emails.find params[:id]
    @camp_email.update_attributes params[:campaign_email]
    respond_to do |format|
      format.json { render json: @camp_email.to_json }
    end
  end

  def destroy
    @camp_email = @campaign.campaign_emails.find params[:id]
    @camp_email.destroy
    redirect_to @campaign
  end

  def xeditable? object = nil
    can?(:edit, object) ? true : false
  end
  helper_method :xeditable?

  private

  def load_campaign
    @campaign = Campaign.find params[:campaign_id]
  end
end