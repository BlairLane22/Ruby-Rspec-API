require_relative '../config/sequel'
module ExpenseTracker
  ResultRecord = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      unless expense.key?('payee')
        message = "Invalid expense: payee is required"
        return ResultRecord.new(false, nil, message)
      end

      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      ResultRecord.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end
  end
end
