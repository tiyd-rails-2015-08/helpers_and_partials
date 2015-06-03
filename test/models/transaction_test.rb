require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "can get total" do
    assert_equal 50, Transaction.total
  end

  test "knows withdrawals v. deposits" do
    assert_equal [transactions(:three), transactions(:one)], Transaction.deposits
    assert_equal [transactions(:six), transactions(:four), transactions(:two),
        transactions(:five)], Transaction.withdrawals
  end

  test "amount spent this month" do
    six = transactions(:six)
    five = transactions(:five)
    six.update(created_at: six.created_at - 3.month)
    five.update(created_at: five.created_at - 1.month)
    assert_equal 250, Transaction.spent_this_month
  end

end
