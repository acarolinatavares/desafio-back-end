class CreateTransactionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_types do |t|
      t.integer :type_code
      t.string :description
      t.integer :kind

      t.timestamps
    end
  end
end
