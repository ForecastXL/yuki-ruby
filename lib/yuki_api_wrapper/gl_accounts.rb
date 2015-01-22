module YukiApiWrapper
  class Client
    def gl_account_balance(opts = {})
      required = [:transactionDate]
      check_required_parameters(required, opts)
      # sessionID:
      # administrationID:
      # transactionDate: -> Use end date per year
      opts = { body:
                { sessionId: self.session_id,
                  administrationId: self.administration_id,
                  transactionDate: opts.fetch(:transactionDate) }
             }
      post('/GLAccountBalance', opts)
    end

    def gl_account_transactions(opts = {})
      required = [:GLAccountCode, :StartDate, :EndDate]
      check_required_parameters(required, opts)
      # sessionID:
      # administrationID:
      # GLAccountCode:
      # StartDate:
      # EndDate:
      opts = { body:
                { sessionId: self.session_id,
                  administrationId: self.administration_id,
                  GLAccountCode: '80000',
                  StartDate: '2014-12-31 15:19:33 +0100',
                  EndDate: '2016-12-31 15:19:33 +0100'}
             }
      post('/GLAccountTransactions', opts)
    end
  end
end