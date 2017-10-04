class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	def index
		render '/dashboard/index'
	end

	protected

	def configure_permitted_parameters
		attributes = [:admin, :superadmin, :has_reserved]
		devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
		devise_parameter_sanitizer.permit(:account_update, keys: attributes)
	end

	private

	def is_admin
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
	end

	def is_superadmin
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.superadmin?)
	end

	def is_admin_or_superadmin
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin? or current_user.superadmin?)
	end

	def update_car_status
		@reservations = Reservation.all
		unless @reservations.blank?
			@reservations.each do |res|
				if !res.checked_out and ((Time.now - res.check_out)/60) > 30
					# Cancel reservation
					if res.destroy
						@c = Car.find(res.car_id)
						@c.status = "available"
						@c.save
						@u = User.find(res.user_id)
						@u.update :has_reserved => false
					end
				end

				if res.checked_out and !res.returned and ((Time.now-res.return)/60)>=0
					# Make car available
					@c = Car.find(res.car_id)
					@c.status = "available"
					@c.save
					@u = User.find(res.user_id)
					@u.update :has_reserved => false
				end
			end
		end
	end
end
