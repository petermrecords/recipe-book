class Admin::SessionsController < ApplicationController
	def new
	end

	def create
		@admin = Admin.kept.find_by(email: params[:email])
		if @admin && @admin.authenticate(params[:password])
			session[:admin] = @admin.id
			redirect_to new_admin_path
		elsif @admin
			@error = 'Password is incorrect'
			render :new
		else
			@error = 'No user with that email exists'
			render :new
		end
	end

	def destroy
		if session[:admin]
			session[:admin] = nil
			redirect_to new_admin_path
		end
	end
end
