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

  def self.transactions_this_month
    this_month = all.select {|t| t.created_at.month == DateTime.now.month}
    this_month.count
  end

  def self.transactions_last_month
    last_month = all.select {|t| t.created_at.month == DateTime.now.month - 1}
    last_month.count
  end

  def self.biggest_this_month
    this_month = withdrawals.select {|t| t.created_at.month == DateTime.now.month}
    sorted = this_month.sort_by {|t| t.amount}
    sorted.last
  end

  def self.biggest_ever
    sorted = withdrawals.sort_by {|t| t.amount}
    sorted.last
  end

  def self.money_pit
    costs = (withdrawals.map {|t| t.recipient}).to_set
    most = 0
    biggest = nil
    costs.each do |c|
      list = Transaction.where(recipient: c)
      total = list.reduce(0) {|sum, t| t.amount + sum}
      if total > most
        biggest = c
        most = total
      end
    end
    biggest
  end
end
