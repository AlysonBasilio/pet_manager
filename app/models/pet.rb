class Pet < ApplicationRecord
  belongs_to :owner

  validates :name, :monthly_cost, :kind, :owner, presence: true
  validate :andorinha_owners_cannot_be_under_eighteen,
           :cat_owners_cant_have_a_name_that_starts_with_letter_a,
           :owner_cant_have_pets_if_they_already_spend_more_than_1000
 
  def andorinha_owners_cannot_be_under_eighteen
    if kind == 'Andorinha' && owner.age < 18
      errors.add(:owner_ir, "andorinha owners can't be under eighteen")
    end
  end
  
  def cat_owners_cant_have_a_name_that_starts_with_letter_a
    if kind == 'Gato' && owner.name.first == 'A'
      errors.add(:owner_ir, "cat owners can't have a name that starts with letter a")
    end
  end
  
  def owner_cant_have_pets_if_they_already_spend_more_than_1000
    if owner.present? && owner.current_spent > 1000
      errors.add(:owner_ir, "owner can't have one more pet if they already spend more than 1000")
    end
  end
end
