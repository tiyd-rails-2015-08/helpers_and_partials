require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "can get total" do
    #fixtures: two $100 deposits & one $150 withdrawal
    assert_equal 50, Transaction.total
  end
end
