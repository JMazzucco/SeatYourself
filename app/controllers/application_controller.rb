class ApplicationController < ActionController::Base
  before_action :require_login
  around_filter :user_time_zone, if: :current_user

  private
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def not_authenticated
    redirect_to root_path, alert: "Please login first"
  end
end
