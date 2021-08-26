class ApplicationController < ActionController::Base

	# para que los metodos esten disponibles en los templates
	helper_method :current_user, :logged_in?

	def current_user
		@currenty_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:alert] = 'Debes estar logeado para hacer eso!'
			redirect_to root_path
		end
	end

	def access_denied
		flash[:alert] = 'No puedes hacer eso'
		redirect_to root_path
	end

end
