require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a secure password" do
    user = User.create(username: 'Barry', password: 'burton')
    expect(user.save).to be true
    expect(user.authenticate('not-secret')).to be false
  end

  it "should fail on bad password confirmation" do
    user = User.create(
      username: 'Jill',
      password: 'valentine',
      password_confirmation: 'sonata'
    )
    expect(user.save).to be false
  end

  it "should succeed on good password confirmation" do
    user = User.create(
      username: 'Rebecca',
      password: 'chambers',
      password_confirmation: 'chambers'
    )
  end
end
