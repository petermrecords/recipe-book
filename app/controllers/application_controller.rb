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

	def authorize_current_admin
		if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to admin_login_path and return
		elsif	!(params[:id] == session[:admin] || current_admin.email == ENV['SUPER_ADMIN_EMAIL_ADDRESS'])
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end

	def authorize_super_admin
		if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to admin_login_path and return
		elsif !(current_admin.email == ENV['SUPER_ADMIN_EMAIL_ADDRESS'])
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end
end
