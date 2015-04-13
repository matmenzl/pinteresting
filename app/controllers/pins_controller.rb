class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :populate_pins, only: :index
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :validate_location, only: [:show, :edit, :update]

  def index
    if params[:filter]
      @pins = current_user.address.empty? ? Pin.where(zip: current_user.zip) : Pin.near(current_user.address, 1)
      @pins = @pins.marked_as(params[:filter].downcase.to_sym)
    else
      # @pins = params[:search] ? Pin.near(current_user.zip).search(params[:search]) : @q.result(distinct: true)
      @pins = @q.result(distinct: true)
    end
    build_map @pins
    @pins = @pins.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
    @location = Geocoder.search("#{current_user.latitude}, #{current_user.longitude}").first.data["formatted_address"] if user_signed_in? && @pins.empty? && params[:q].nil?
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      @pin.mark_as params[:pin_type].downcase.to_sym, current_user
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  def contact_owner
    PinsContact.owner(current_user.email, Pin.find(params[:id]).user.email, params[:message]).deliver
    flash[:notice] = "Your Message has been sent!"
    redirect_to root_path
  end

  def share
    PinsContact.share(current_user, params[:email], params[:id]).deliver
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    def build_map pins
      @markers = current_user.build_markers(pins) if current_user
    end

    def populate_pins
      if user_signed_in?
        @q = current_user.address.empty? ? Pin.where(zip: current_user.zip).ransack(params[:q]) : Pin.near(current_user.address, 1).ransack(params[:q])
      else
        @q = Pin.ransack(params[:q])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :address, :status, :zip)
    end
end