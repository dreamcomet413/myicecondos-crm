# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class EmailsController < ApplicationController
  before_filter :require_user, except: :email_webhook
  protect_from_forgery except: :email_webhook

  # DELETE /emails/1
  # DELETE /emails/1.json
  # DELETE /emails/1.xml                                                   AJAX
  #----------------------------------------------------------------------------
  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    respond_with(@email)
  end

  def email_webhook
    params["mandrill_events"] = JSON.parse(params["mandrill_events"])
    render nothing: true and return unless params["mandrill_events"].first.try(:[], "event") == "open"
    email_id = params["mandrill_events"].first.try(:[], "msg").try(:[], "metadata").try(:[], "email_id")
    Email.where(id: email_id).first.update_attributes(opened: true) if email_id
    render nothing: true
  end

end
