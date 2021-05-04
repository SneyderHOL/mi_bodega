class AccountsController < ApplicationController
  skip_before_action :authenticate_user!
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
      render file: "#{Rails.root}/public/404.html",
              layout: false, status: :not_found
    end
  end

  private

  def set_accounts
    @accounts = current_user.accounts
  end 
end
