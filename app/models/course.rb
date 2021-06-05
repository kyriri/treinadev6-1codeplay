class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons
  
  validates :name, 
            :code,
            :price,
            presence: { message: "não pode ficar em branco" }
  validates :code, uniqueness: { message: "já está em uso" }

  # scopes can be seen as custom query filters, can be chained
  scope :available, -> { where(enrollment_deadline: Date.current..) } #, draft: false }
  scope :price_asc, -> { order(price: :asc) } # or :desc

  # scope is the same as:
  # def self.available
  #   where(enrollment_deadline: Date.current..)
  # end
  # however, a method might not be chainable
end
