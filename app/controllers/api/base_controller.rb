class Api::BaseController < ActionController::Base
  before_filter :restrict_access

private

  def restrict_access
    render json: { error: "Invalid API Token." }.to_json, status: 400 and return unless params[:token] == APP_CONFIG[:api_token]
    render json: { error: "Missing Lead Parameters." }.to_json, status: 400 and return unless params[:lead].present?
  end
end
