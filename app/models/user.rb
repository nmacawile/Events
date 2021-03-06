class User < ApplicationRecord
  has_many :events_hosted, class_name: "Event", foreign_key: :host_id, dependent: :destroy
  has_many :attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :events_attended, through: :attendances, source: :event_attended
  has_many :invites_sent, class_name: "Invite", foreign_key: :inviter_id, dependent: :destroy
  has_many :invites_received, class_name: "Invite", foreign_key: :invitee_id, dependent: :destroy
  has_many :events_invited_to, class_name: "Event", through: :invites_received, source: :event
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
  
  def attending?(event)
    self.events_attended.exists? event
  end
end
