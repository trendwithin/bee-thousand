require 'test_helper'

class AlertTest < ActiveSupport::TestCase
  def setup
    @user = users(:vic)
    @alert = Alert.new(symbol: 'TEST', entry: '100.00', stop: '99.00',
                       target: '105.00', shares: 100, comment: 'none',
                       user_id: @user.id)
  end

  test 'alert is valid' do
    assert @alert.valid?
  end

  test 'symbol must be present' do
    @alert.symbol = ''
    refute @alert.valid?
  end

  test 'maximum symbol length of 6' do
    @alert.symbol = '123456'
    assert @alert.valid?
  end

  test 'symbol length of 7 invalid' do
    @alert.symbol = '1234567'
    refute @alert.valid?
  end

  test 'entry must be present' do
    @alert.entry = nil
    refute @alert.valid?
  end


  test 'maximum entry length of 6' do
    @alert.entry = '100000'
    assert @alert.valid?
  end

  test 'entry length of 7 invalid' do
    @alert.entry = '1000000'
    refute @alert.valid?
  end

  test 'maximum stop length of 6' do
    @alert.stop = '100000'
    assert @alert.valid?
  end

  test 'stop length of 7 invalid' do
    @alert.stop = '1000000'
    refute @alert.valid?
  end

  test 'shares length of 6 valid' do
    @alert.shares = '100000'
    assert @alert.valid?
  end

  test 'shares length of 7 invalid' do
    @alert.shares = '1000000'
    refute @alert.valid?
  end

  test 'target length of 6 valid' do
    @alert.target = '100000'
    assert @alert.valid?
  end

  test 'target lenght of 7 invalid' do
    @alert.target = '1000000'
    refute @alert.valid?
  end

  test 'presence of user_id' do
    @alert.user_id = ''
    refute @alert.valid?
  end
end
