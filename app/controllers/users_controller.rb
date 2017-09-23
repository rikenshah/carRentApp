class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin_or_superadmin

  def show
  	@users = User.where(admin: false, superadmin: false)
  	@admins = User.where(admin: true)
  	@superadmins = User.where(superadmin: true)
  end

end
