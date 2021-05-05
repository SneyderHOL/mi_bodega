class BoxesController < ApplicationController
  before_action :account_have_been_choose?, only: [:show, :index, :new, :create]
  before_action :validate_user_belongs_to_account, only: [:show, :create]
  
  def index
    @boxes = current_account.boxes.all
  end

  def show
    @box = current_account.boxes.where(id: params[:id]).first
    unless @box
      not_found
    end
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params.merge(account: current_account))
    if @box.save
      flash[:notice] = "Box was created successfully."
      redirect_to @box
    else
      render 'new'
    end
  end

  private

  def box_params
    params.require(:box).permit(:name)
  end

  def validate_user_belongs_to_account
    unless current_account.users.include?(current_user)
      flash[:alert] = "You don't have permissions to perform that action"
      redirect_to root_path
    end
  end

  def account_have_been_choose?
    unless current_account
      flash[:alert] = "You have to choose an account to perform that action"
      redirect_to accounts_path
    end
  end
end
