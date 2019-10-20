class Owner < ApplicationRecord
  has_many :pets
  
  validates :name, :document, :birth_date, presence: true
  validate :all_pets_are_valid

  def all_pets_are_valid
    pets.each do |pet|
      errors.add(:pets, "#{pet} is invalid") unless pet.valid?
    end
  end

  def current_spent
    pets.sum(:monthly_cost)
  end

  def three_month_cost
    current_spent * 3
  end

  def age
    ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
  end
end
