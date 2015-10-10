class LandingsController < ApplicationController
  before_filter :set_current_tab
  def new
    @landing = Landing.new
  end
  
  def create
    @landing = Landing.new params[:landing]
    @landing.slug = @landing.slug.gsub(/\s+/, "") if @landing.slug.present?
    if @landing.save
      redirect_to landings_path, notice: "Created successfully"
    else
      render "new"
    end
  end
  
  def edit
    @landing = Landing.find params[:id]
  end
  
  def update
    @landing = Landing.find params[:id]
    @landing.assign_attributes params[:landing]
    @landing.slug = @landing.slug.gsub(/\s+/, "") if @landing.slug.present?
    if @landing.save
      redirect_to landings_path, notice: "Saved successfully"
    else
      render "edit"
    end
  end
  
  def index
    @landings = Landing.all
  end
  
  def destroy
    @landing = Landing.find params[:id]
    @landing.destroy
    redirect_to landings_path
  end
end