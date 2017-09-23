module ApplicationHelper
	def is_admin
		current_user.admin?
	end

	def is_superadmin
		current_user.superadmin?
	end

	def is_admin_or_superadmin
		current_user.admin? or current_user.superadmin?
	end

	def is_customer
		!(current_user.admin? or current_user.superadmin?)
	end
end
