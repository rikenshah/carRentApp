class ReservationsController < ApplicationController
  include ApplicationHelper
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /reservations
  # GET /reservations.json
  def index
    if is_admin_or_superadmin
      @reservations = Reservation.all
    else
      puts current_user.id
      @reservations = Reservation.where(:user_id => current_user.id)
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @car_id = params[:car_id]
    @user_id = current_user.id
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create()
    @reservation = Reservation.new(reservation_params)
    puts "Hello"
    @check_out_time = DateTime.new(reservation_params["check_out(1i)"].to_i,
                       reservation_params["check_out(2i)"].to_i,
                       reservation_params["check_out(3i)"].to_i,
                       reservation_params["check_out(4i)"].to_i,
                       reservation_params["check_out(5i)"].to_i)
    @return_time = DateTime.new(reservation_params["return(1i)"].to_i,
                       reservation_params["return(2i)"].to_i,
                       reservation_params["return(3i)"].to_i,
                       reservation_params["return(4i)"].to_i,
                       reservation_params["return(5i)"].to_i)
    @difference_in_minutes = ((@return_time - @check_out_time)*24*60).to_i
    if @difference_in_minutes<60 or @difference_in_minutes>600
      redirect_to '/cars', notice: 'Invalid time. Minimum for 1 hour, Maximum for 10 hours'
    else
      respond_to do |format|
        if @reservation.save
          current_user.update_attributes(:has_reserved => true)
          format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
          format.json { render :show, status: :created, location: @reservation }
        else
          format.html { render :new }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :car_id, :check_out, :return, :checked_out, :returned)
    end
end
