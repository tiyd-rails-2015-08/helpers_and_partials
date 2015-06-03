class Transaction < ActiveRecord::Base

  def self.withdrawals
    all.select {|t| t.transaction_type == "Withdrawal"}
  end

  def self.deposits
    all.select {|t| t.transaction_type == "Deposit"}
  end

  def self.total
    expenses = withdrawals.reduce(0) {|sum, t| sum + t.amount}
    income = deposits.reduce(0) {|sum, t| sum + t.amount}

    income - expenses
  end

  def self.spent_this_month
    this_month = withdrawals.select {|t| t.created_at.month == DateTime.now.month}
    this_month.reduce(0) {|sum, t| sum + t.amount}
  end

  def self.spent_last_month
    last_month = withdrawals.select {|t| t.created_at.month == DateTime.now.month - 1}
    last_month.reduce(0) {|sum, t| sum + t.amount}
  end
end
