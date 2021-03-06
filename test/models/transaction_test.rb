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

  test "amount spent last month" do
    six = transactions(:six)
    five = transactions(:five)
    six.update(created_at: six.created_at - 1.month)
    five.update(created_at: five.created_at - 1.month)
    assert_equal 300, Transaction.spent_last_month
  end

  test "transactions this month" do
    six = transactions(:six)
    five = transactions(:five)
    one = transactions(:one)
    six.update(created_at: six.created_at - 1.month)
    five.update(created_at: five.created_at - 1.month)
    one.update(created_at: one.created_at - 2.months)
    assert_equal 3, Transaction.transactions_this_month
  end

  test "transactions last month" do
    six = transactions(:six)
    five = transactions(:five)
    one = transactions(:one)
    six.update(created_at: six.created_at - 1.month)
    five.update(created_at: five.created_at - 1.month)
    one.update(created_at: one.created_at - 2.months)
    assert_equal 2, Transaction.transactions_last_month
  end

  test "biggest expense this month" do
    six = transactions(:six)
    five = transactions(:five)
    six.update(created_at: six.created_at - 1.month)
    five.update(created_at: five.created_at - 1.month)
    assert_equal "The Mall: $150.00", Transaction.biggest_this_month
  end

  test "biggest expense ever" do
    six = transactions(:six)
    five = transactions(:five)
    six.update(created_at: six.created_at - 2.month)
    five.update(created_at: five.created_at - 1.month)
    assert_equal "The Mall: $250.00", Transaction.biggest_ever
  end

  test "where'd my money go" do
    assert_equal "The Mall", Transaction.money_pit
  end
end
