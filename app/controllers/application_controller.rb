class ApplicationController < ActionController::Base
		# para que los metodos esten disponibles en los templates
	helper_method :current_user

	def require_user
		redirect_to sign_in_path unless current_user
	end

	def current_user
		User.find(session[:user_id]) if session[:user_id]
	end
end
