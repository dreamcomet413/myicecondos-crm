# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class UserMailer < ActionMailer::Base

  def password_reset_instructions(user)
    @edit_password_url = edit_password_url(user.perishable_token)

    mail :subject => "Ice Condos CRM: " + I18n.t(:password_reset_instruction),
         :to => user.email,
         :from => from_address,
         :date => Time.now
  end

  def new_lead(user, lead)
    @lead = lead
    mail :subject => "Ice Condos CRM: You have been assigned a new lead",
         :to => user.email,
         :from => from_address
  end

  def new_lead_created(admins, lead)
    @lead = lead
    mail :subject => "Nicholas Alli CRM: A new lead has been created",
         :to => admins.collect(&:email),
         :from => from_address
  end

  def contact_form(lead_params)
    @lead_params = lead_params
    mail :subject => "Nicholas Alli Contact Form: #{lead_params[:email]}",
         :to => User.where(admin: true).collect(&:email),
         :reply_to => lead_params[:email],
         :from => from_address
  end

  def assigned_entity_notification(entity, assigner)
    @entity_url = url_for(entity)
    @entity_name = entity.name
    @entity_type = entity.class.name
    @assigner_name = assigner.name
    mail :subject => "Ice Condos CRM: You have been assigned #{@entity_name} #{@entity_type}",
         :to => entity.assignee.email,
         :from => from_address
  end

  def email_template_sample(user, lead, email_template)
    @email_content = parse_liquid(email_template.body, lead, user)
    attachments.inline['header_image.png'] = Paperclip.io_adapters.for(email_template.header_image).read if email_template.header_image.present?
    mail(subject: "Ice Condos CRM Sample: #{email_template.subject}", to: user.email, from: from_address) do |format|
      format.html { render "email_body" }
    end
  end

  def campaign_email(lead, email_template)
    return unless lead.email.present?
    @email_content = parse_liquid(email_template.body, lead, lead.assignee)
    e = Email.create(mediator: lead, sent_from: from_address, sent_to: lead.email, subject: "Ice Condos: #{email_template.subject}", body: @email_content, sent_at: DateTime.now, imap_message_id: DateTime.now.to_i)
    attachments.inline['header_image.png'] = Paperclip.io_adapters.for(email_template.header_image).read if email_template.header_image.present?
    mail(subject: "Ice Condos: #{email_template.subject}", to: lead.email, from: from_address) do |format|
      format.html { render "email_body" }
    end
    headers["X-MC-Track"] = "opens"
    headers['X-MC-Metadata'] = { "email_id" => e.id}.to_json
  end

  def manual_email(lead, email_template, user)
    return unless lead.email.present?
    @email_content = parse_liquid(email_template.body, lead, user)
    e = Email.create(mediator: lead, sent_from: from_address, sent_to: lead.email, subject: "Ice Condos: #{email_template.subject}", body: @email_content, sent_at: DateTime.now, imap_message_id: DateTime.now.to_i)
    attachments.inline['header_image.png'] = Paperclip.io_adapters.for(email_template.header_image).read if email_template.header_image.present?
    mail(subject: "Ice Condos: #{email_template.subject}", to: lead.email, from: user.email) do |format|
      format.html { render "email_body" }
    end
    headers["X-MC-Track"] = "opens"
    headers['X-MC-Metadata'] = { "email_id" => e.id}.to_json
  end

  private

  def from_address
    from = (Setting.smtp || {})[:from]
    !from.blank? ? from : "Ice Condos <noreply@icecondos.com>"
  end

  def parse_liquid(body, lead, user=nil)
    Liquid::Template.parse(body).render({
      "FirstName" => lead.first_name,
      "LastName" => lead.last_name,
      "Phone" => lead.phone,
      "UserFirstName" => user.try(:first_name),
      "UserLastName" => user.try(:last_name)
    })
  end

end
