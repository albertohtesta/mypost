class User < ActiveRecord::Base
	include Sluggable
	
	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 4} 
	# en update no se dispara esta validacion

	sluggable_column :username

	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator'
	end

	def two_factor_auth?
		!self.phone.blank?
	end

	def generate_pin!
		self.update_column(:pin, rand(10**6))
	end

	def remove_pin!
		self.update_column(:pin, nil)
	end

	def send_pin_to_twilio
		account_sid = Rails.application.credentials.dig(:twilio, :account_sid)
		auth_token = Rails.application.credentials.dig(:twilio, :auth_token)
		from = '+13187540386'
		to = "+521#{phone}"
		client = Twilio::REST::Client.new(account_sid, auth_token)
		#account = client.account
		msg = "Hola por favor introduce el pin para continuar el login: #{self.pin}"
		client.messages.create(from: from, to: to, body: msg)
	end

end
