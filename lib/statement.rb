
class Statement

	attr_reader :transactions

	def initialize
		@transactions = Array.new
	end

	def store(transaction)
		@transactions << transaction
	end



end