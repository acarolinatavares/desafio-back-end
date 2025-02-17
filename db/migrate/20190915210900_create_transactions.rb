class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :transaction_type, foreign_key: true
      t.datetime :occurrence_date
      t.string :card
      t.references :store, foreign_key: true
      t.monetize :value

      t.timestamps
    end
  end
end
