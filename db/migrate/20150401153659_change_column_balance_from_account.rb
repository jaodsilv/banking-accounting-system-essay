class ChangeColumnBalanceFromAccount < ActiveRecord::Migration
  def change
    change_column :accounts, :balance, :decimal, scale: 3, precision: 5
  end
end
