class LeadAssignmentRulesController < ApplicationController
  before_filter :set_current_tab
  def new
    @rule = LeadAssignmentRule.new
  end

  def create
    prepare_rule_information
    @rule = LeadAssignmentRule.new params[:lead_assignment_rule]
    if @rule.save
      redirect_to lead_assignment_rules_path, notice: "Created successfully"
    else
      render "new"
    end
  end

  def edit
    @rule = LeadAssignmentRule.find params[:id]
  end

  def update
    @rule = LeadAssignmentRule.find params[:id]
    prepare_rule_information
    @rule.assign_attributes params[:lead_assignment_rule]
    if @rule.save
      redirect_to lead_assignment_rules_path, notice: "Saved successfully"
    else
      render "edit"
    end
  end

  def index
    @rules = LeadAssignmentRule.all
  end

  def destroy
    @rule = LeadAssignmentRule.find params[:id]
    @rule.destroy
    redirect_to lead_assignment_rules_path
  end

  private

  def prepare_rule_information
    params[:lead_assignment_rule][:information] = {}
    params[:lead_assignment_rule][:information][:users] = {}
    params[:lead_assignment_rule][:information][:assigned_leads_count] = 0
    params[:sales_reps].each do |sales_rep|
      h = {sales_rep[:id] => {percentage: sales_rep[:percentage], current_count: 0}}
      params[:lead_assignment_rule][:information][:users].merge! h
    end if params[:sales_reps].present?
    params[:lead_assignment_rule][:information][:users] = Hash[params[:lead_assignment_rule][:information][:users].sort_by{|k,v| -v["percentage"].to_i}]
  end
end