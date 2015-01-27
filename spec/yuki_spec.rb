require 'spec_helper'

describe YukiApiWrapper do
  before do
    # p "PLS FILL IN API KEY: ......"
    # key = STDIN.gets.chomp
    @client = YukiApiWrapper::Client.new({access_key: "d7895de9-56ba-41be-a9a9-51e0fb699451"})
  end

  describe 'authentication' do
    it "should #authenticate and return a session id" do
      expect(@client.authenticate).to eq @client.session_id
    end
  end

  describe '#administrations selection' do
    before do
      @client.authenticate
    end

    it "should retrieve available #administrations" do
      expect(@client.administrations).not_to be_empty
      p @client.session_id
      p @client.administrations
    end
  end


  describe 'Api calls within an administration' do
    before do
      @client.authenticate
      @client.administration_id = @client.set_first_administration_id
    end
    it "should retrieve GLTransactions" do
      opts = {GLAccountCode: '80000', StartDate: '2014-12-31 15:19:33 +0100', EndDate: '2015-12-31 15:19:33 +0100'}
      p @client.gl_account_transactions(opts)
    end

    it "should retrieve GLTransactionsFiscal" do
      opts = {GLAccountCode: '80000', StartDate: '2014-12-31 15:19:33 +0100', EndDate: '2015-12-31 15:19:33 +0100'}
      p "GLTransactionsFiscal"
      p @client.gl_account_transactions(opts)
    end

    it "should reject empty GLTransactions hashes" do
      opts = {GLAccountCode: '80000', StartDate: '2013-12-31 15:19:33 +0100', EndDate: '2014-12-31 15:19:33 +0100'}
      p @client.gl_account_transactions(opts)
    end

    it "should retrieve GLAccountBalances" do
      p "GLAccountBalances"
      p @client.gl_account_balance(transactionDate: '2015-12-31 15:19:33 +0100')
    end

    it "should retrieve unique GLAccountBalances using the end of the year of each year in range" do
      p "GLAccountBalances per year"
      p @client.gl_account_balance_in_range({start_date: '2013-01-31 15:19:33 +0100' , end_date: '2015-12-31 15:19:33 +0100'})
    end
  end
end