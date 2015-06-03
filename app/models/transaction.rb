class Transaction < ActiveRecord::Base

  def self.total
    withdrawals = all.select {|t| t.transaction_type == "Withdrawal"}
    deposits = all.select {|t| t.transaction_type == "Deposit"}

    expenses = withdrawals.reduce(0) {|sum, t| sum + t.amount}
    income = deposits.reduce(0) {|sum, t| sum + t.amount}

    income - expenses
  end
end
