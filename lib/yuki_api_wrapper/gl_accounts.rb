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

    def gl_account_balance_in_range(opts = {})
      required = [:start_date, :end_date]
      check_required_parameters(required, opts)
      # sessionID:
      # administrationID:
      # transactionDate: -> Use end date per year


      range = Date.strptime(opts.fetch(:start_date)).year..Date.strptime(opts.fetch(:end_date)).year
      transactionDates = []

      range.each{ |date| transactionDates << DateTime.new(date).end_of_year}

      opts = { body:
                { sessionId: self.session_id,
                  administrationId: self.administration_id
                }
             }

      results = []

      transactionDates.uniq.each do |transaction_date|
        results << post('/GLAccountBalance', opts.deep_merge(body: { transactionDate: transaction_date.to_formatted_s(:db) }))
      end

      final_results = []
      results.each do |r|
        unless r.fetch('GLAccountBalance').nil?
          r.fetch('GLAccountBalance')['GLAccount'].each do |rr|
            final_results << rr
          end
        end
      end

      final_results
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
                  GLAccountCode: opts.fetch(:GLAccountCode),
                  StartDate: opts.fetch(:StartDate),
                  EndDate: opts.fetch(:EndDate)}
             }
      post('/GLAccountTransactions', opts)
    end

    def gl_account_transactions_fiscal(opts = {})
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
                  GLAccountCode: opts.fetch(:GLAccountCode),
                  StartDate: opts.fetch(:StartDate),
                  EndDate: opts.fetch(:EndDate)}
             }
      post('/GLAccountTransactionsFiscal', opts)
    end
  end
end