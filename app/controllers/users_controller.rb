class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :is_admin_or_superadmin, except: [:new, :create]
  before_action :allow_without_password, only: [:update]
  skip_before_action :verify_authenticity_token

 def index
  	@users = User.where(admin: false, superadmin: false)
  	@admins = User.where(admin: true)
  	@superadmins = User.where(superadmin: true)
  end

  def new
  	@users = User.new
  	logger.debug(@users)
  end

  def savenew
  	id = User.maximum(:id).next
	  # sql = "insert into users (id,email,encrypted_password,admin,superadmin,created_at,updated_at) values( #{id},
	  #       #{ActiveRecord::Base.connection.quote(params[:user][:email])},
	  #       #{ActiveRecord::Base.connection.quote(params[:user][:password])},
	  #       #{ActiveRecord::Base.connection.quote(params[:user][:admin])},
	  #       #{ActiveRecord::Base.connection.quote(params[:user][:superadmin])},
	  #       datetime('now'), datetime('now'))"
	  # ActiveRecord::Base.connection.execute(sql)
	  @u = User.create(:id => id, :email => params[:user][:email], :password_confirmation => params[:user][:password_confirmation],:password => params[:user][:password], :admin => params[:user][:admin], :superadmin => params[:user][:superadmin], :created_at => Time.now, :updated_at => Time.now)
	  if @u.save
	  	  respond_to do |format|  ## Add this
	  		format.html { redirect_to users_url, notice: 'User was successfully created.' }
			format.json { render :show, status: :created, location: @user }
		end
	  else
	  	  respond_to do |format|  ## Add this
	  	  	temp = "Could not save user \n"
	  	  	@u.errors.each do |e,v|
	  	  		temp = temp + ":"+ e.to_s + " - "+ v	
	  	  	end
		  	 format.html { redirect_to users_url, notice: temp }
			  format.json { render json: @u.errors, status: :unprocessable_entity }
	  	end
	  end
	end

def show
	# print "Hello"
	logger.debug(params)
	@user = User.find(params[:id])
	@user_reservations = Reservation.where(:user_id => @user.id)
	@user_checkout_history = {}
	unless @user_reservations.empty?
		@user_reservations.each.with_index do |r,index|
			print r.car_id
			@c = Car.find(r.car_id)
			@temp = {}
			@temp[:car_model] = @c.model
			@temp[:check_out] = r.check_out
			@temp[:return] = r.return
			@temp[:checked_out] = r.checked_out
			@temp[:returned] = r.returned
			@user_checkout_history[r.id] = @temp
		end
	end
end

  def create
    @user = User.new(user_params)
    # don't send email notifications from admin interface
	redirect_to action: 'index'
  end
  
  def update

  end

  def destroy
  	print "hello"
  	logger.debug(params)
  	@user = User.find(params[:id])
	@r = Reservation.where(:user_id => @user.id)

  	if @user.destroy
  		unless @r.empty?
  			@c = Car.find(@r.car_id)
		 	@c.status = "available"
		 	@c.save
		 	@r.destroy
		 end
	 	 respond_to do |format|  ## Add this
		  	 format.html { redirect_to users_url, notice: 'User was successfully deleted' }
	  	end
	 end
  end
private
    def allow_without_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end
    end

end
