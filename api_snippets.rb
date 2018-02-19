class API < Sinatra::Base
  def initialize(ledger:)
    @ledger = ledger
    super() # rest of initialization from sinatra
  end
end

# Later call does this:
app = API.new(ledger: Ledger.new)



# Rseudocode for what happens inside the API class:
#
result = @ledger.record({ 'some' => 'data' })
result.success?       # => a Boolean
result.expense_id     # => a number
result.error_message  # => a string or nil
