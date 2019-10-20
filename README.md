## Respostas

Qual é o custo médio dos animais do tipo cachorro?
Query: `Pet.where(kind: 'Cachorro').average(:monthly_cost)`
Resposta: 99.99

Quantos cachorros existem no sistema?
Query: `Pet.where(kind: 'Cachorro').count`
Resposta: 2

Qual o nome dos donos dos cachorros (Array de nomes)
Query: `Pet.includes(:owner).where(kind: 'Cachorro').map{ |pet| pet.owner.name }`
Resposta: ["Sid Vicious", "Axl Rose"]

Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)
Query: `Owner.all.sort_by { |owner| -owner.current_spent }`
Resposta:
Elvis Presley: 407.99
Johnny Cash: 199.99
Kurt Cobain: 177.99
Joey Ramone: 103.99
Bruce Dickinson: 103.99
Sid Vicious: 99.99
Axl Rose: 99.99

Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?
Query: `Owner.all.map { |owner| owner.three_month_cost }`
Resposta:
Johnny Cash: 599.97
Sid Vicious: 299.97
Axl Rose: 299.97
Joey Ramone: 311.97
Bruce Dickinson: 311.97
Kurt Cobain: 533.97
Elvis Presley: 1223.97