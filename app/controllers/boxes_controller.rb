class BoxesController < ApplicationController
  def index
    @boxes = Box.all
  end

  def show
    @box = Box.find_by(id: params[:id])
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params)
  end

  private

  def box_params
    params.require(:box).permit(:name)
  end
end
