class UsersController < ApplicationController
	before_action :require_user, only: :show

	def new
		@user = User.new
	end

  def show
    @user = User.find(params[:id])
  end


	def create
	    @user = User.new(user_params)
	    if @user.save     
	      handle_invitation
	      EmailJob.perform_later(@user)
	      #AppMailer.send_welcome_email(@user).deliver

=begin
	      StripeWrapper::Charge.create({
	        :amount => 999,
	        :source => params[:stripeToken],
	        :description => "Sign UP Charge for #{@user.email}"
	      })
=end
	      redirect_to sign_in_path
	    else
	      render :new
	    end
    end

  def new_with_invitation_token
    invitation = Invitation.find_by_token(params[:token])
    if invitation
      @user = User.new(email: invitation.email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

	private

	def user_params
		params.require(:user).permit(:email, :password, :full_name, :invitation_token)
	end

	def handle_invitation
	  if params[:invitation_token].present?
		invitation = Invitation.find_by(token: params[:invitation_token])
      	@user.follow(invitation.inviter)
      	invitation.inviter.follow(@user)
      	invitation.update_column(:token, nil)
      end
	end

end