class Api::LeadsController < Api::BaseController

  def load_from_client
    if params[:lead][:email].present?
      lead = Lead.find_or_initialize_by_email params[:lead][:email]
      if params[:lead][:requested_info].present?
        params[:lead][:requested_info] = lead.requested_info.present? ? lead.requested_info + "      ------|------      " + params[:lead][:requested_info] : params[:lead][:requested_info]
      end
      if params[:lead][:listing_info_lead_is].present?
        params[:lead][:listing_info_lead_is] = params[:lead][:listing_info_lead_is] == "Both" ? "Both buying and selling" : params[:lead][:listing_info_lead_is]
      end
      ba = lead.business_address || lead.build_business_address
      ba.assign_attributes params[:lead][:address]
      lead.assign_attributes params[:lead].except(:user, :address)
      lead.save
      process_contact(lead) if params[:lead].has_key?(:user)
    else
      Lead.create params[:lead]
    end
    if params[:lead][:requested_info].present?
      UserMailer.contact_form(params[:lead]).deliver
    end
    render nothing: true
  end

  private

  def process_contact lead
    c = Contact.where(email: lead.email).first
    return if c
    contact_attributes = {}
    %w(first_name last_name title source email alt_email phone mobile blog linkedin facebook twitter skype do_not_call background_info).each do |name|
      contact_attributes[name] = lead.send(name.intern)
    end
    lead.create_contact contact_attributes
  end
end
