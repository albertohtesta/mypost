require "rails_helper"

describe UsersController do
=begin
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
=end

  describe "POST create" do

    context "with valid user" do

      before {post :create, params: { user: Fabricate.attributes_for(:user)} }
      it "creates the new user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Invitation.create(inviter: alice, email: "joe@example.com", name: "Joe", message: "Hello")
        post :create, params: { user: {email: "joe@example.com",password: "12345678", full_name: "Joe Doe"}, invitation_token: invitation.token}
        joe = User.find_by(email: "joe@example.com")
        expect(joe.follow?(alice)).to be_truthy
      end
      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Invitation.create(inviter: alice, email: "joe@example.com", name: "Joe", message: "Hello")
        post :create, params: { user: {email: "joe@example.com",password: "12345678", full_name: "Joe Doe"}, invitation_token: invitation.token}
        joe = User.find_by(email: "joe@example.com")
        expect(alice.follow?(joe)).to be_truthy
      end
      it "expires the invitation upon the acceptance" do
        alice = Fabricate(:user)
        invitation = Invitation.create(inviter: alice, email: "joe@example.com", name: "Joe", message: "Hello")
        post :create, params: { user: {email: "joe@example.com",password: "12345678", full_name: "Joe Doe"}, invitation_token: invitation.token}
        expect(Invitation.first.token).to be_nil
      end
    end

    context "email sending" do
      after { ActionMailer::Base.deliveries.clear }
      it "sends out the email with valid inputs" do
        post :create, params: { user: {email: "xiaocui@test.com", password: "password", full_name: "xiaocui"}}
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["xiaocui@test.com"])
      end
      it "sends out email contains the user's name with valid inputs" do
        post :create, params: { user: {email: "xiaocui@test.com", password: "password", full_name: "xiaocui"}}
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("xiaocui")
      end
      it "doesn't send email with unvalid inputs" do
        post :create, params: { user: {email: "xiaocui@test.com", full_name: "xiaocui"}}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "with invalid user" do
      before { post :create, params: { user: {password: "password", full_name: "xiaocui"} } }
      it "does not create new user" do
        expect(User.count).to eq(0)
      end
      it "render new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

  end

  describe "GET show" do
    it_behaves_like "require_sign_in" do
      let(:action) {get :show, params: {id: 3}}
    end
    it "set @user variable" do
      alice = Fabricate(:user)
      set_current_user(alice)
      get :show, params: {id: alice.id}
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "GET new_with_invitation_token" do
    it "renders the new template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, params: { token: invitation.token }
      expect(response).to render_template :new
    end
    it "set @user with recipient email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, params: { token: invitation.token }
      expect(assigns(:user).email).to eq(invitation.email)
    end
    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, params: { token: invitation.token }
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end
    it "redirects to the expired token page for invalid token" do
      get :new_with_invitation_token, params: { token: "ddfsaesfa" }
      expect(response).to redirect_to expired_token_path
    end
  end

end