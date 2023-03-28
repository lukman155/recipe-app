class DeviseMailer < ApplicationMailer
  default from: 'your-email@example.com'

  def reset_password_instructions(record, token, _opts = {})
    @resource = record
    @token = token
    mail(to: @resource.email, subject: 'Reset your password')
  end
end
