class JsonWebToken
  # SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  SECRET_KEY = "secretkey!!!!!"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    p token = JWT.encode(payload, SECRET_KEY,'HS256')
  end

  def self.decode(token)
    p token
    decoded = JWT.decode(token, SECRET_KEY, ['HS256']).first
    HashWithIndifferentAccess.new decoded
  end


end