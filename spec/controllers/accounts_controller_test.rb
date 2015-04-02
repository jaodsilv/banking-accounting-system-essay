require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:valid_attributes) {
    { balance: 7 }
  }

  let(:invalid_attributes) {
    { balance: -1 }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all accounts as @accounts" do
      account = Account.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:accounts)).to eq([account])
    end
  end

  describe "GET #balance" do
    it "assigns the requested balance in @message" do
      account = Account.create! valid_attributes
      get :balance, {:id => account.to_param}, valid_session
      expect(assigns(:message)).to eq("Balance: #{account.balance}")
    end
  end

  describe "GET #new" do
    it "assigns a new account as @account" do
      get :new, {}, valid_session
      expect(assigns(:account)).to be_a_new(Account)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, {:account => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end

      it "redirects to the list of accounts" do
        post :create, {:account => valid_attributes}, valid_session
        expect(response).to redirect_to(accounts_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(assigns(:account)).to be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST #transfer" do
    let(:source) { Account.create! valid_attributes }
    let(:destination) { Account.create! valid_attributes }

    context "with valid params" do
      let(:transfer_params) { {
        source_id: source.to_param,
        destination_id: destination.to_param,
        amount: source.balance
      } }

      it "updates the requested accounts" do
        source_balance = source.balance
        destination_balance = destination.balance
        post :transfer, transfer_params, valid_session
        source.reload
        destination.reload
        expect(source.balance).to eq(0)
        expect(destination.balance).to eq(source_balance+destination_balance)
      end
    end

    context "with invalid params" do
      let(:transfer_params) { {
        source_id: source.to_param,
        destination_id: destination.to_param,
        amount: source.balance+1
      } }

      it "assigns the error message to @message" do
        put :transfer, transfer_params, valid_session
        expect(assigns(:message)).to eq("Source account doesn't have enought credit.")
      end
    end
  end
end
