# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

owner_seeds = [
  {
    name: 'Johnny Cash',
    document: 555555555,
    birth_date:	'1932-02-26'
  }, {
    name: 'Sid Vicious',
    document: 555555555,
    birth_date:	'1957-05-10'
  }, {
    name: 'Axl Rose',
    document: 555555555,
    birth_date:	'1962-02-6 '
  }, {
    name: 'Joey Ramone',
    document: 555555555,
    birth_date:	'1951-05-19'
  }, {
    name: 'Bruce Dickinson',
    document: 555555555,
    birth_date:	'1958-08-7 '
  }, {
    name: 'Kurt Cobain',
    document: 555555555,
    birth_date:	'1967-02-20'
  }, {
    name: 'Elvis Presley',
    document: 555555555,
    birth_date:	'2008-08-17'
  }
]

owner_seeds.each do |owner_seed|
  Owner.create(owner_seed)
end

pet_seeds = [
  {
    name: 'Pé de Pano',
    monthly_cost: 199.99,
    kind: 'Cavalo',
    owner_name: 'Johnny Cash'
  }, {
    name: 'Rex',
    monthly_cost: 99.99,
    kind: 'Cachorro',
    owner_name: 'Sid Vicious'
  }, {
    name: 'Ajudante do Papai Noel',
    monthly_cost: 99.99,
    kind: 'Cachorro',
    owner_name: 'Axl Rose'
  }, {
    name: 'Rex',
    monthly_cost: 103.99,
    kind: 'Papagaio',
    owner_name: 'Joey Ramone'
  }, {
    name: 'Flora',
    monthly_cost: 103.99,
    kind: 'Lhama',
    owner_name: 'Bruce Dickinson'
  }, {
    name: 'Dino',
    monthly_cost: 177.99,
    kind: 'Iguana',
    owner_name: 'Kurt Cobain'
  }, {
    name: 'Lassie',
    monthly_cost: 407.99,
    kind: 'Ornitorrinco',
    owner_name: 'Elvis Presley'
  }
]

pet_seeds.each do |pet_seed|
  owner = Owner.find_by_name(pet_seed[:owner_name])
  
  Pet.create(pet_seed.except(:owner_name).merge(owner_id: owner.id))
end