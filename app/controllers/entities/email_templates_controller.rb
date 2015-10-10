class EmailTemplatesController < ApplicationController
  before_filter :set_current_tab
  def new
    @template = current_user.email_templates.new
  end

  def create
    @template = current_user.email_templates.new params[:email_template]
    if @template.save
      redirect_to email_templates_path, notice: "Created successfully"
    else
      render "new"
    end
  end

  def edit
    @template = current_user.email_templates.find params[:id]
  end

  def update
    @template = current_user.email_templates.find params[:id]
    @template.assign_attributes params[:email_template]
    if @template.save
      redirect_to email_templates_path, notice: "Saved successfully"
    else
      render "edit"
    end
  end

  def index
    @templates = current_user.email_templates
  end

  def destroy
    @template = current_user.email_templates.find params[:id]
    @template.destroy
    redirect_to email_templates_path
  end

  def sample
    @template = current_user.email_templates.find params[:id]
    sample_lead = OpenStruct.new(first_name: "Test", last_name: "Lead", phone: "519-555-5555")
    UserMailer.email_template_sample(current_user, sample_lead, @template).deliver
    redirect_to email_templates_path, notice: "Sample email was sent successfully"
  end
end