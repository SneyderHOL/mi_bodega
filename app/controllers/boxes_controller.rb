class BoxesController < ApplicationController
  before_action :validate_user_belongs_to_account, only: [:show]
  
  def index
    @boxes = Box.all
  end

  def show
    @box = Box.find(params[:id])
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
end
