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
end
