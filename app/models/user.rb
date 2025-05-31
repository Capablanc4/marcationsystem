class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
end
