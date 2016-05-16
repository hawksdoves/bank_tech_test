require_relative 'transaction'
require_relative 'statement'

class Bank

	attr_reader :statement, :transaction

	def initialize(transaction=Transaction)
		@statement = Statement.new
		@transaction = transaction
	end

	def deposit(amount)
		new_transaction = @transaction.new
		new_transaction.type_credit(amount)
		@statement.store(new_transaction)
	end

	def withdrawal(amount)
		new_transaction = @transaction.new
		new_transaction.type_debit(amount)
		@statement.store(new_transaction)
	end

	def print_statement
		p "date || credit || debit || balance"
		@statement.transactions.each do |transaction|
			@statement.update_balance(credit_or_debit(transaction))			
			p transaction.date.to_s + " || " + transaction.credit.to_s + " || " + transaction.debit.to_s + " || " + @statement.balance.to_s
		end
	end

	private

	def credit_or_debit(transaction)
		if transaction.credit === 0
			-transaction.debit
		else
			transaction.credit
		end
	end


end