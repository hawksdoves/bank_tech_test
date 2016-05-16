require 'statement'

describe Statement do 

	subject(:statement) { described_class.new }
	let(:transaction) { double :transaction }

	describe '#initialize' do

		it 'has a balance of zero' do
			expect(statement.balance).to eq(0)
		end

		it 'has a transactions array that is empty' do
			expect(statement.transactions).to be_empty
		end

	end

	describe '#store' do

		it 'increases the transactions array by 1' do
			expect {statement.store(transaction)}.to change{statement.transactions.length}.by 1
		end
	end

	describe '#update_balance' do

		it 'changes the balance' do			
			expect {statement.update_balance(1000)}.to change{statement.balance}.by 1000
		end

	end
	
end