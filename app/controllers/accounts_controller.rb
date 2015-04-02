class AccountsController < ApplicationController

  def main
  end

  def transfer
    begin
      source = Account.find(params[:source_id])
      destination = Account.find(params[:destination_id])
      amount = params.require(:amount).to_f
      if amount <= 0
        raise Exception.new("Amount should be greater than 0")
      end
      source.debit(amount)
      destination.credit(amount)
      @message = "Tranference completed successfully."
    rescue Exception => e
      @message = e.message
    end
    render :main
  end

  def balance
    begin 
      account = Account.find(params[:id])
      @message = "Balance: #{account.balance}"
    rescue Exception => e
      @message = e.message
    end
    render :main
  end

  # Calls for testing

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to :accounts, notice: 'Account was successfully created.' }
        format.json { render :accounts, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:balance)
    end
end
