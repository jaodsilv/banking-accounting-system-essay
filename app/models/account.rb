class Account < ActiveRecord::Base
  def debit amount
    if amount > self.balance
      raise Exception.new("Not enought balance")
    end
    self.balance -= amount
  end

  def credit amount
    self.balance += amount
  end
end
