class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_current_tenant
  helper_method :set_current_account, :current_account, :current_user_is_admin?

  # def set_current_account(account = nil)
  def set_current_tenant(account = nil)
    if account
      session[:account_id] = account.id
      @current_account = account
    else
      @current_account ||= Account.find_by(id: session[:account_id])
    end
  end

  def current_account
    #@current_account = set_current_account
    @current_account = set_current_tenant
  end

  def current_user_is_admin?
    account_user = AccountUser.where(account: current_account, admin: true).first
    return true if account_user&.user == current_user
    false
  end

  def after_sign_in_path_for(resource)
    accounts_path
  end
end
