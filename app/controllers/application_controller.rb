class ApplicationController < ActionController::Base
	def current_admin
		@current_admin ||= Admin.kept.find(session[:admin]) if session[:admin]
	end

	def authorize_admin
		 if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to admin_login_path
		end
	end
end
