class Instructor < ApplicationRecord
  has_many :courses
  has_one_attached :profile_picture

  validates :name, :email,
            presence: { message: "não pode ficar em branco" }
  validates :email, uniqueness: { message: "já cadastrado em outro registro" }

  def display_name
    "#{name} - #{email}"
  end
end
