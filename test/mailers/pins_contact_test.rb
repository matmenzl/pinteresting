require 'test_helper'

class PinsContactTest < ActionMailer::TestCase
  test "owner" do
    mail = PinsContact.owner
    assert_equal "Owner", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "interest" do
    mail = PinsContact.interest
    assert_equal "Interest", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
