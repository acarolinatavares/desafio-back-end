TransactionType.create(
    [
        {type_code: 1, description: 'Débito', kind: :in},
        {type_code: 2, description: 'Boleto', kind: :out},
        {type_code: 3, description: 'Financiamento', kind: :out},
        {type_code: 4, description: 'Crédito', kind: :in},
        {type_code: 5, description: 'Recebimento Empréstimo', kind: :in},
        {type_code: 6, description: 'Vendas', kind: :in},
        {type_code: 7, description: 'Recebimento TED', kind: :in},
        {type_code: 8, description: 'Recebimento DOC', kind: :in},
        {type_code: 9, description: 'Aluguel', kind: :out}
    ]
)
