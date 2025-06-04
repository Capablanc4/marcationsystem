class AttendanceRecord < ApplicationRecord
  RECORD_TYPES = %w[entrada salida inicio_break fin_break].freeze
  belongs_to :user
  validates :date, presence: true
  validates :time, presence: true
  validates :record_type, presence: true,
            inclusion: { in: RECORD_TYPES }
  validates :comment, length: { minimum: 0, maximum: 300 }, allow_blank: true
  validates :record_type, uniqueness: {
    scope: [ :user_id, :date ],
    message: "Ya has registrado este tipo de evento hoy"
  }
  scope :for_user, ->(user) { where(user: user) }
  scope :for_date, ->(date) { where(date: date) }
  scope :by_time, -> { order(:time) }

  def self.record_types_for_select
    RECORD_TYPES.map { |r| [ r.humanize.capitalize, r ] }
  end
end
