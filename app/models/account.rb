class Account < ActiveRecord::Base
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0.0 } 

  def debit amount
    if amount > self.balance
      raise Exception.new("Source account doesn't have enought credit.")
    end
    self.balance -= amount
    self.save
  end

  def credit amount
    self.balance += amount
    self.save
  end
end
