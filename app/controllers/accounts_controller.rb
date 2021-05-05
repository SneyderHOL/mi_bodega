class AccountsController < ApplicationController
  before_action :set_accounts

  def index
  end

  def update
    account = Account.find_by(id: params[:id])
    if account && @accounts.include?(account)
      #set_current_account(account) # set_tenant
      set_current_tenant(account)
      redirect_to root_path
    else
      not_found
    end
  end

  private

  def set_accounts
    @accounts = current_user.accounts
  end 
end
