class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_permissions

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if current_account.users.include?(@user)
      flash.now[:alert] = "User is already registered in account"
      render 'new' and return
    end
    unless @user
      @user = User.new(user_params)
      unless @user.save
        flash.now[:alert] = "Something went wrong"
        render 'new' and return
      end
    end
    @user.add_account(current_account)
    flash[:notice] = "User added successfully to account"
    redirect_to add_new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def validate_permissions
    unless current_user_is_admin?
      flash[:alert] = "You don't have permissions to perform that action"
      redirect_to root_path
    end
  end
end
