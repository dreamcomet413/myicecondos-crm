class ProspectMatchesController < ApplicationController
  def new
    redirect_to root_path unless current_user
    params[:property_types] = ""
    @prospect_match = ProspectMatch.new
    @lead = Lead.find params[:lead_id]
  end

  def create
    redirect_to root_path unless current_user
    @prospect_match = ProspectMatch.new(params[:prospect_match])
    params[:property_types] ||= []
    @prospect_match.property_types = params[:property_types].join(",")
    @prospect_match.city = params[:locality]
    @lead = Lead.find params[:lead_id]
    @alli_user = SiteUser.where(email: @lead.email).first
    @prospect_match.user_id = @alli_user.id
    if @prospect_match.save
      redirect_to @lead, notice: "You have successfully subscribed the user for regular updates."
    else
      render "new"
    end
  end

  def edit
    redirect_to root_path unless current_user
    @prospect_match = ProspectMatch.where(id: params[:id]).first
    redirect_to root_path unless @prospect_match
    params[:city] = @prospect_match.city
    params[:locality] = @prospect_match.city
    params[:property_types] = @prospect_match.property_types || ""
    @lead = Lead.find params[:lead_id]
  end

  def update
    redirect_to root_path unless current_user
    @prospect_match = ProspectMatch.where(id: params[:id]).first
    redirect_to root_path unless @prospect_match
    @prospect_match.assign_attributes(params[:prospect_match])
    params[:property_types] ||= []
    @prospect_match.property_types = params[:property_types].join(",")
    @prospect_match.city = params[:locality]
    @lead = Lead.find params[:lead_id]
    if @prospect_match.save
      redirect_to @lead, notice: "You have successfully changed user's settings."
    else
      render "edit"
    end
  end

  def destroy
    redirect_to root_path unless current_user
    @prospect_match = ProspectMatch.where(id: params[:id]).first
    redirect_to root_path unless @prospect_match
    @prospect_match.destroy
    @lead = Lead.find params[:lead_id]
    redirect_to @lead
  end
end
