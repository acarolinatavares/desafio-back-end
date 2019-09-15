class TransactionType < ApplicationRecord
    enum kind: [:in, :out]
end
