require 'rails_helper'

RSpec.describe Owner do
  context 'associations' do
    it 'has_many pets' do
      association = described_class.reflect_on_association(:pets)
      expect(association.macro).to eq :has_many
    end
  end

  context 'validations' do
    let(:valid_data) { { name: 'Alyson', document: 123123, birth_date: '2019-01-08' } }
    let(:valid_described_class_instance) { described_class.new(valid_data) }
    let(:described_class_instance_without_name) { described_class.new(valid_data.except(:name)) }
    let(:described_class_instance_without_document) { described_class.new(valid_data.except(:document)) }
    let(:described_class_instance_without_birth_date) { described_class.new(valid_data.except(:birth_date)) }
    
    it 'validates presence of name, document and birth_date attributes' do 
      expect(valid_described_class_instance.valid?).to be_truthy
    end
    
    it 'validates presence of document attribute' do
      expect(described_class_instance_without_document.valid?).to be_falsey
    end
    
    it 'validates presence of birth_date attribute' do
      expect(described_class_instance_without_birth_date.valid?).to be_falsey
    end
  end

  context '#current_spent' do
    let(:valid_data) { { name: 'Bruno', document: 123123, birth_date: '2019-01-08' } }
    let(:owner_without_pets) { described_class.create(valid_data) }
    let!(:owner_with_pets) { described_class.create(valid_data) }
    let!(:dog) { Pet.create(name: 'Rin-Tin-Tin', monthly_cost: 200, kind: 'Cachorro', owner_id: owner_with_pets.id) }
    let!(:cat) { Pet.create(name: 'Mingau', monthly_cost: 100, kind: 'Gato', owner_id: owner_with_pets.id) }

    it 'sums all costs from every pet that an owner have' do
      expect(owner_without_pets.current_spent).to eq(0)
      expect(owner_with_pets.current_spent).to eq(dog.monthly_cost + cat.monthly_cost)
    end
  end
end