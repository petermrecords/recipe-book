class ApplicationController < ActionController::Base
	def current_admin
		@current_admin ||= Admin.kept.find(session[:admin]) if session[:admin]
	end

	private
	def authorize_admin
		if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to login_path
		end
	end

	def authorize_account_owner
		if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to login_path and return
		elsif	!(params[:id] == current_admin.id || current_admin.is_super_admin?)
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end

	def authorize_super_admin
		if !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to login_path and return
		elsif !current_admin.is_super_admin?
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end

	def authorize_recipe_owner(id)
		@recipe ||= Recipe.find(id)
		if @recipe && !current_admin
			flash[:notice] = 'You must be logged in to access this.'
			redirect_to login_path and return
		elsif @recipe && !(@recipe.author == current_admin || current_admin.is_super_admin?)
			flash[:alert] = 'You are not authorized to access this.'
			redirect_to :back
		end
	end

	def errors_alert(header, errors)
		errors.each do |error|
			header << "* " << error << "\r\n"
		end
		header
	end
end
