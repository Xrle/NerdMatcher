require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test 'should return contact email' do
    mail = ContactMailer.contact_email('Harry Hill', 'test@test.com', 'Test email!')
    assert_equal ['info@nerdmatcher.com'], mail.to
    assert_equal ['info@nerdmatcher.com'], mail.from
  end
end
