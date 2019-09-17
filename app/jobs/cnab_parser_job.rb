class CnabParserJob < ApplicationJob
  queue_as :default

  DELIMITERS = {
    type: 0..0,
    date: 1..8,
    value: 9..18,
    document: 19..29,
    card: 30..41,
    hour: 42..47,
    owner_name: 48..61,
    store: 62..80
  }

  def perform(file_path)
    transactions_file = File.open(file_path, "r")
    transactions_file.each do |line|
      get_transaction_type(line)
      get_store(line) if @transaction_type
      create_transaction(line) if @store
    end
    transactions_file.close
  end

  private

  def get_transaction_type(line)
    type_code = line[DELIMITERS[:type]]
    @transaction_type = TransactionType.find_by(type_code: type_code)
  end  

  def get_store(line)
    document = line[DELIMITERS[:document]]
    owner = Owner.find_or_initialize_by(document: document)
    owner.name = line[DELIMITERS[:owner_name]].strip
    if owner.valid? && owner.save
      store_name = line[DELIMITERS[:store]].strip
      store = Store.find_or_initialize_by(name: store_name, owner_id: owner.id)
      @store = store.valid? && store.save ? store : nil
    end
  end

  def create_transaction(line)
    occurrence_date = "#{line[DELIMITERS[:date]][6..7]}/#{line[DELIMITERS[:date]][4..5]}/#{line[DELIMITERS[:date]][0..3]}"
    occurrence_hour = "#{line[DELIMITERS[:hour]][0..1]}:#{line[DELIMITERS[:hour]][2..3]}:#{line[DELIMITERS[:hour]][4..5]}"
    transaction = Transaction.new(store_id: @store.id,
                                  transaction_type_id: @transaction_type.id, 
                                  card: line[DELIMITERS[:card]],
                                  occurrence_date: "#{occurrence_date} #{occurrence_hour}",
                                  value_cents: line[DELIMITERS[:value]].to_i)
    transaction.save if transaction.valid?
  end 
end
