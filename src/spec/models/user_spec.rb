require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前を登録すると、名前を取得できる" do
    user = User.new(name: "sample")
    expect(user.name).to eq "sample"
  end
end
