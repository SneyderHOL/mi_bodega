class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :use_item, :edit, :update]

  def show
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item was created successfully."
      redirect_to box_item_path(box_id: @item.box.id, id: @item.id)
    else
      render 'new'
    end
  end

  def use_item
    if @item.user == nil
      @item.user = current_user
      save_and_redirect
    elsif @item.user && @item.user == current_user
      @item.user = nil
      save_and_redirect
    else
      flash.now[:alert] = "Item is already in use"
      render 'show'
    end
  end

  def edit
  end

  def update
    new_box = Box.find(update_item_params[:new_box])
    if @item.box.account.boxes.include?(new_box)
      @item.box = new_box
      @item.save
      redirect_to new_box
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def save_and_redirect
    @item.save
    redirect_to box_item_path(box_id: @item.box.id, id: @item.id)
  end

  def item_params
    params.require(:item).permit(:description, :picture, :box_id)
  end

  def update_item_params
    params.require(:item).permit(:new_box)
  end
end
