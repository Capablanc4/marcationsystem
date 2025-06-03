class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :attendance_records, dependent: :destroy
  before_save { self.username = username.downcase.strip }
  before_save { self.lastname = lastname.downcase.strip }
  validates :username, length: { minimum: 2, maximum: 30 },
                       presence: true,
                       format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/,
                               message: "solo puede contener letras y espacios" }
  validates :lastname, length: { minimum: 2, maximum: 30 },
                       presence: true,
                       format: { with: /\A[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+\z/,
                               message: "solo puede contener letras y espacios" }

  def records_today
    attendance_records.for_date(Date.current).by_time
  end

  def last_record_today
    records_today.last
  end
end
