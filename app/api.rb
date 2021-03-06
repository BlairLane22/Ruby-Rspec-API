require 'sinatra/base'
require 'json'
require_relative 'ledger'

module ExpenseTracker
  class API < Sinatra::Base

    def initialize(ledger: Ledger.new)  # default value so callers can just say API.new and get the default
      @ledger = ledger
      super() # rest of initialization from sinatra
    end

    post '/expenses' do
      # status 404

      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)

      if result.success?
        JSON.generate('expense_id' => result.expense_id)
      else
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

    get '/expenses/:date' do

      # expense = JSON.parse(request.body.read)
      # result = @ledger.record(date)

      # if result.success?
      #   status 200
      #   JSON.generate('expense_id' => result.expense_id)
      # else
      #   status 200
      #   JSON.generate([])
      # end
    end
  end
end
