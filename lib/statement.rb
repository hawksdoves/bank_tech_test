
class Statement

	attr_reader :balance, :transactions

	def initialize
		@balance = 0
		@transactions = Array.new
	end

	def store(transaction)
		@transactions << transaction
	end

	def update_balance(amount)
		@balance += amount
	end

end