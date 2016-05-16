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

	def print_statement(boolean=true)
		balance = ascending_display_balance(boolean)
		display_ascending_transactions(boolean).each_with_index do |transaction, index|
			balance += ( display(boolean, index) * ascending_cumulative_balance(boolean, index) )
			p transaction.date.to_s + " || " + transaction.credit.to_s + " || " + transaction.debit.to_s + " || " + balance.to_s
		end
	end

	def print_only_withdrawals(boolean=true)
		balance = ascending_display_balance(boolean)
		display_ascending_transactions(boolean).each_with_index do |transaction, index|
			balance += ( display(boolean, index) * ascending_cumulative_balance(boolean, index) )
			if credit_or_debit(transaction) < 0	
				p transaction.date.to_s + " || " + transaction.debit.to_s + " || " + balance.to_s
			end
		end
	end

	def print_only_deposits(boolean=true)
		balance = ascending_display_balance(boolean)
		display_ascending_transactions(boolean).each_with_index do |transaction, index|
			balance += ( display(boolean, index) * ascending_cumulative_balance(boolean, index) )
			if credit_or_debit(transaction) > 0	
				p transaction.date.to_s + " || " + transaction.credit.to_s + " || " + balance.to_s
			end
		end
	end

	private

	def current_balance
		amounts_array = @statement.transactions.map do |transaction|
			credit_or_debit(transaction)
		end
		amounts_array.reduce(0, :+)
	end

	def display_ascending_transactions(boolean)
		boolean ? @statement.transactions : @statement.transactions.reverse
	end

	def ascending_display_balance(boolean)
		boolean ? 0 : current_balance
	end

	def credit_or_debit(transaction)
		transaction.credit === 0 ? -transaction.debit : transaction.credit
	end

	

	def display(boolean, index)
		if (!boolean && index === 0)
			0
		else
			transaction = display_ascending_transactions(boolean)[(index+previous_index(boolean))]
			credit_or_debit(transaction)
		end
	end

	def previous_index(boolean)
		boolean ? 0 : -1
	end

	def ascending_cumulative_balance(boolean, index)
		boolean ? 1 : -1
	end

end