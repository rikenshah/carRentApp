class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	def index
		render '/dashboard/index'
	end

	protected

	def configure_permitted_parameters
		attributes = [:admin, :superadmin]
		devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
		devise_parameter_sanitizer.permit(:account_update, keys: attributes)
	end

	private

	def verify_is_admin
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
	end

	def verify_is_superadmin
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.superadmin?)
	end

	def can_access_users
		(current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin? or current_user.superadmin?)
	end
end
