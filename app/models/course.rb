class Course < ApplicationRecord
  has_one :instructor
  
  validates :name, 
            :code,
            :price,
            presence: { message: "não pode ficar em branco" }
  validates :code, uniqueness: { message: "já está em uso" }
end
