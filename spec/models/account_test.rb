require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "balance" do
    it "return balance value" do
      account = FactoryGirl.build(:account_two)
      expect(account.balance).not_to eq(0.0)
      expect(account.balance).not_to eq(nil)
    end
  end

  describe "debit" do
    it "change balance if sufficient balance" do
      account = FactoryGirl.build(:account_two)
      balance = account.balance - 25
      account.debit(25.0)
      expect(account.balance).to eq(balance)
    end

    it "raises error if not sufficient balance" do
      account = FactoryGirl.build(:account_one)
      expect { account.debit 25.0 }.to raise_error(Exception, "Not enought balance")
    end
  end

  describe "credit" do
    it "changes balance" do
      account = FactoryGirl.build(:account_one)
      balance = account.balance + 25.0
      account.credit(25.0)
      expect(account.balance).to eq(balance)
    end
  end
end
