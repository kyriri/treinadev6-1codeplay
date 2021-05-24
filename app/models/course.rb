class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons
  
  validates :name, 
            :code,
            :price,
            presence: { message: "não pode ficar em branco" }
  validates :code, uniqueness: { message: "já está em uso" }
end
