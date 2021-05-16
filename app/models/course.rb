class Course < ApplicationRecord
  validates :name, 
            :description,
            :code,
            :price,
            :enrollment_deadline,
            presence: { message: "não pode ficar em branco" }
  validates :code, uniqueness: { message: "já está em uso" }
end
