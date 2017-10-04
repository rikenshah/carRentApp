class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :is_admin_or_superadmin, only:[:edit, :update, :destroy, :new]

  # GET /cars
  # GET /cars.json
  def index
  @cars = Car.all
  @current_bigining_time = Time.now.beginning_of_day
  @carres = Hash.new()
  @cars.each { |car|
    Rails.logger.debug("Cars.each call thayu")
    @ress = Array.new()
    Reservation.all.each {|res_local|
      next unless car.id == res_local.car_id
      # puts @ress.length.to_s
      @carres[car.id] = Array.new() if @carres[car.id].nil?
      @carres[car.id].push(res_local) unless @carres[car.id].nil?
    }
    @carres[car.id] = @ress if @carres[car.id].nil?
  }
  @cararray = Hash.new();
  @carres.each { |key, value|
    @cararray[key] = Array.new(168,0)
    value.each{ |res|
      startHours = ((res.check_out - Time.now.beginning_of_day) / 3600 ).round
      endHours = ((res.return - Time.now.beginning_of_day) / 3600 ).round
      return if startHours < 0 or endHours < 0
      (endHours - startHours + 1).times{ |i|
        @cararray[key][startHours + i] = 1
      }
      # Rails.logger.debug("Hours: #{startHours.inspect} #{endHours.inspect}")
    }
  } 
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    if @car.destroy
      @r = Reservation.where(:car_id => params[:id]).first
      unless @r.blank?
        @u = User.find(@r.user_id)
        @u.update :has_reserved => false
        @r.destroy
      end
      respond_to do |format|
        format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:status, :model, :manufacturer, :style, :rent, :location, :licence_plate)
    end
end
