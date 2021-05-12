class BoxesController < ApplicationController
  before_action :account_have_been_choose?, only: [:show, :index, :new, :create]
  before_action :validate_user_belongs_to_account, only: [:show, :create, :show_code]
  before_action :set_box, only: [:show, :show_code]
  
  def index
    @boxes = current_account.boxes.all
  end

  def show
    unless @box
      not_found
    end
  end

  def show_code
    @qr_code = @box.qr_code
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params.merge(account: current_account))
    if @box.save
      qr_code = generate_qr_code
      @box.update(qr_code: qr_code)
      byebug
      flash[:notice] = "Box was created successfully."
      redirect_to @box
    else
      render 'new'
    end
  end

  private

  def set_box
    @box = current_account.boxes.where(id: params[:id]).first
  end

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

  def generate_qr_code
    require 'rqrcode'
    box_dir = request.url + "/#{@box.id}"
    qr = RQRCode::QRCode.new(box_dir)
    qr_code = qr.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 11,
      standalone: true
    )
  end
end
