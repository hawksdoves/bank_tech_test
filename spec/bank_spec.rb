require 'bank'

describe Bank do 

	subject(:bank) { described_class.new }
	let(:statement) { double :statement }
	let(:transaction) { double :transaction, credit: 5, debit: 0, date: Time.now }

	describe 'initialize' do

		it 'with an instance of a statement' do
			allow(Statement).to receive(:new).and_return(statement)
			expect(bank.statement).to eq statement
		end

		it 'with the Transaction class' do
			expect(bank.transaction).to eq Transaction
		end

	end	

	describe '#deposit' do

		it 'creates an instance of Transaction and calls the type_credit method ' do			
			allow(Transaction).to receive(:new).and_return(transaction)
			expect(transaction).to receive(:type_credit)
      bank.deposit(1000)
		end

		it 'calls the statement store method ' do	
			allow(Statement).to receive(:new).and_return(statement)		
			allow(statement).to receive(:store).and_return(transaction)
			expect(bank.statement).to receive(:store)
      bank.deposit(1000)
		end

	end

	describe '#withdrawal' do

		it 'creates an instance of Transaction and calls the type_debit method ' do			
			allow(Transaction).to receive(:new).and_return(transaction)
			expect(transaction).to receive(:type_debit)
      bank.withdrawal(1000)
		end

		it 'calls the statement store method ' do	
			allow(Statement).to receive(:new).and_return(statement)		
			allow(statement).to receive(:store).and_return(transaction)
			expect(bank.statement).to receive(:store)
      bank.withdrawal(1000)
		end

	end

	describe '#print_statement' do

		it 'calls the statement method, update balance ' do	
			allow(bank.statement).to receive(:transactions).and_return([transaction])
			allow(statement).to receive(:update_balance)		
			expect(bank.statement).to receive(:update_balance)
      bank.print_statement
		end

	end

	
end