require "rails_helper"

RSpec.describe AccountsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/accounts").to route_to("accounts#index")
    end

    it "routes to #new" do
      expect(:get => "/accounts/new").to route_to("accounts#new")
    end

    it "routes to #create" do
      expect(:post => "/accounts").to route_to("accounts#create")
    end

    it "routes to #main" do
      expect(:get => "/").to route_to("accounts#main")
    end

    it "routes to #transfer" do
      expect(:post => "/transfer").to route_to("accounts#transfer")
    end

    it "routes to #balance" do
      expect(:get => "/balance").to route_to("accounts#balance")
    end

  end
end
