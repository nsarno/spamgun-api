require 'jwt'

module AuthToken
  def AuthToken.issue_token payload
    JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256' , { exp: 1.day }
  end

  def AuthToken.valid? token
    JWT.decode token, Rails.application.secrets.secret_key_base
  rescue
    false
  end
end
