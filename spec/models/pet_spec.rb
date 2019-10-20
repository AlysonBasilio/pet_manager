require 'rails_helper'

RSpec.describe Pet do
  context 'associations' do
    it 'belongs_to owner' do
      association = described_class.reflect_on_association(:owner)
      expect(association.macro).to eq :belongs_to
    end
  end

  context 'validations' do
    let(:valid_owner) { Owner.create(name: 'Bruno', document: 123123, birth_date: '2019-01-08') }
    let(:valid_data) { { name: 'Jumentchu', monthly_cost: 10, kind: 'Jumento', owner_id: valid_owner.id } }
    let(:valid_described_class_instance) { described_class.new(valid_data) }
    let(:described_class_instance_without_name) { described_class.new(valid_data.except(:name)) }
    let(:described_class_instance_without_monthly_cost) { described_class.new(valid_data.except(:monthly_cost)) }
    let(:described_class_instance_without_kind) { described_class.new(valid_data.except(:kind)) }
    let(:described_class_instance_without_owner) { described_class.new(valid_data.except(:owner_id)) }
    
    it 'validates presence of name, monthly_cost and kind attributes' do 
      expect(valid_described_class_instance.valid?).to be_truthy
    end
    
    it 'validates presence of monthly_cost attribute' do
      expect(described_class_instance_without_monthly_cost.valid?).to be_falsey
    end
    
    it 'validates presence of kind attribute' do
      expect(described_class_instance_without_kind.valid?).to be_falsey
    end
    
    it 'validates presence of owner' do
      expect(described_class_instance_without_owner.valid?).to be_falsey
    end
    
    it "validates that an Andorinha's owner cant be under eighteen" do
      owner_under_eighteen = Owner.create(
        name: 'Bruno', 
        document: 123123, 
        birth_date: Time.zone.now - 8.years
      )
      invalid_pet = Pet.new(name: 'Piu Piu', monthly_cost: 20, kind: 'Andorinha', owner_id: owner_under_eighteen.id)
      expect(invalid_pet.valid?).to be_falsey
      
      owner_over_eighteen = Owner.create(
        name: 'Bruno', 
        document: 123123, 
        birth_date: Time.zone.now - 20.years
      )
      valid_pet = Pet.new(name: 'Piu Piu', monthly_cost: 20, kind: 'Andorinha', owner_id: owner_over_eighteen.id)
      expect(valid_pet.valid?).to be_truthy
    end
    
    it "validates that a cat owner cant have a name starting with letter A" do
      owner_without_a = Owner.create(
        name: 'Bruno', 
        document: 123123, 
        birth_date: Time.zone.now - 8.years
      )
      owner_with_a = Owner.create(
        name: 'Andilson', 
        document: 123123, 
        birth_date: Time.zone.now - 8.years
      )
      invalid_pet = Pet.new(name: 'Mingau', monthly_cost: 20, kind: 'Gato', owner_id: owner_with_a.id)
      expect(invalid_pet.valid?).to be_falsey

      valid_pet = Pet.new(name: 'Mingau', monthly_cost: 20, kind: 'Gato', owner_id: owner_without_a.id)
      expect(valid_pet.valid?).to be_truthy
    end
    
    it "validates that an owner cant have pets if they already spend more than 1000" do
      owner = Owner.create(
        name: 'Bruno', 
        document: 123123, 
        birth_date: Time.zone.now - 8.years
      )
      valid_cat = Pet.new(name: 'Mingau', monthly_cost: 920, kind: 'Gato', owner_id: owner.id)
      expect(valid_cat.valid?).to be_truthy
      valid_cat.save

      valid_calango = Pet.new(name: 'Rango', monthly_cost: 100, kind: 'Calango', owner_id: owner.id)
      expect(valid_calango.valid?).to be_truthy
      valid_calango.save

      invalid_sibito = Pet.new(name: 'Baleado', monthly_cost: 1, kind: 'Sibito', owner_id: owner.id)
      expect(invalid_sibito.valid?).to be_falsey
    end
  end
end