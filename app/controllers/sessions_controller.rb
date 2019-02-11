class SessionsController < ApplicationController
	def new
	end

	def create
		@admin = Admin.kept.find_by(email: params[:email])
		if @admin && @admin.authenticate(params[:password])
			session[:admin] = @admin.id
			redirect_to new_admin_path
		elsif @admin
			flash[:notice] = 'Password is incorrect'
			render :new
		else
			flash[:notice] = 'No user with that email exists'
			render :new
		end
	end

	def destroy
		if session[:admin]
			session[:admin] = nil
			redirect_to login_path
		end
	end
end
