class Invitation < ActiveRecord::Base
  include Tokenable

  belongs_to :inviter, foreign_key: 'user_id', class_name: "User"
  validates_presence_of :name, :email, :message

  def clear_token!
    update_column(:token, nil)
  end
  
end