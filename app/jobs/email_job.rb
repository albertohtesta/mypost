class EmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    AppMailer.send_welcome_email(user).deliver
  end
end
