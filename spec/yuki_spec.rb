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
      p @client.gl_account_transactions
    end

    it "should retrieve GLAccountBalances" do
      p "GLAccountBalances"
      p @client.gl_account_balance
    end
  end
end