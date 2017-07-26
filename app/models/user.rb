class User < ApplicationRecord
  has_many :hosted_events, class_name: "Event", foreign_key: :host_id
  before_save { email.downcase! }
  has_secure_password
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 250 },
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true,
                       length: { minimum: 6 }
                       
  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end
end
