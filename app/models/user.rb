class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_secure_password
  validates :email, uniqueness: {case_sensitive: false}
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true


  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end

end
