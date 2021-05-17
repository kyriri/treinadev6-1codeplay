class Instructor < ApplicationRecord
    validates :name, :email,
              presence: { message: "não pode ficar em branco" }
  validates :email, uniqueness: { message: "já cadastrado em outro registro" }
end
