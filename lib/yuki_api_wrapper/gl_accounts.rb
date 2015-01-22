module YukiApiWrapper
  class Client
    def gl_account_balance

      # sessionID:
      # administrationID:
      # transactionDate: -> Use end date
      opts = { body:
                { sessionId: self.session_id,
                  administrationId: self.administration_id,
                  transactionDate: '2015-12-31 15:19:33 +0100' }
             }
      post('/GLAccountBalance', opts)
    end

    def gl_account_transactions
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