class Owner < ApplicationRecord
  has_many :pets
  
  validates :name, :document, :birth_date, presence: true

  def current_spent
    pets.sum(:monthly_cost)
  end
end
