class PartialLeadsController < ApplicationController
  before_filter :set_current_tab

  def index
    @q = Lead.unscoped.partial_leads.ransack(params[:q])
    @partial_leads = @q.result.reject{|p| p.business_address.nil?}.paginate(page: params[:page], per_page: 20)
  end
end