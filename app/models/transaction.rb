class Transaction < ActiveRecord::Base

  def self.total
    all.reduce(0) {|sum, t| sum + t.amount}
  end
end
