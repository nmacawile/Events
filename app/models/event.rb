class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :attendances, foreign_key: :event_attended_id, dependent: :destroy
  has_many :attendees, through: :attendances
  has_many :invites, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  scope :unfinished, -> { where("time_end > ?", Time.now ) }
  scope :finished, -> { where("time_end <= ?", Time.now ) }
  validates :title, presence: true,
                    length: { maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates :venue, presence: true, 
                    length: { maximum: 50 }
  validates :time_start, presence: true
  validates :time_end, presence: true
  
  validate :time_end_cannot_be_in_the_past,
           :time_end_must_be_after_time_start
           
  private
  
    def time_end_cannot_be_in_the_past
      if time_end.present? && time_end < DateTime.now
        errors.add(:time_end, "can't be in the past.")
      end
    end
  
    def time_end_must_be_after_time_start
      if time_end.present? && time_start.present? && time_end < time_start
        errors.add(:time_end, "is invalid.")
      end
    end
end
