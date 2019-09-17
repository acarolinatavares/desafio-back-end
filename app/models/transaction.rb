class Transaction < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :store

  monetize :value_cents
end
