require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :balance => 3.14
      ),
      Account.create!(
        :balance => 3.14
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :count => 4
  end
end
