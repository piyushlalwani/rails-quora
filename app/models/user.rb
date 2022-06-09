class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  def name
    "#{first_name} #{last_name}"
  end
end
