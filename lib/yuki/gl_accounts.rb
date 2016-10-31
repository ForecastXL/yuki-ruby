module Yuki
  class Client
    def gl_account_balance(opts = {})
      required = [:transactionDate]
      check_required_parameters(required, opts)

      opts = { body:
                { sessionId: session_id,
                  administrationId: administration_id,
                  transactionDate: opts.fetch(:transactionDate) }
             }
      post('/GLAccountBalance', opts)
    end

    def gl_account_balance_in_range(opts = {})
      required = [:start_date, :end_date]
      check_required_parameters(required, opts)

      year_range = Date.strptime(opts[:start_date]).year..Date.strptime(opts[:end_date]).year
      transactionDates = year_range.map { |year| DateTime.new(year, 12, 31) }.uniq

      opts = { body: { sessionId: session_id, administrationId: administration_id } }

      results = transactionDates.map do |transaction_date|
        post('/GLAccountBalance', opts.deep_merge(body: { transactionDate: transaction_date.to_formatted_s(:db) }))
      end

      final_results = []
      results.each do |year|
        unless year.fetch('GLAccountBalance').nil?
          year.fetch('GLAccountBalance')['GLAccount'].each do |gl_account|
            final_results << gl_account
          end
        end
      end

      final_results
    end

    def gl_account_transactions(opts = {})
      required = [:GLAccountCode, :StartDate, :EndDate]
      check_required_parameters(required, opts)

      opts = { body:
                { sessionId: session_id,
                  administrationId: administration_id,
                  GLAccountCode: opts.fetch(:GLAccountCode),
                  StartDate: opts.fetch(:StartDate),
                  EndDate: opts.fetch(:EndDate)}
             }

      post('/GLAccountTransactions', opts)
    end

    def gl_account_transactions_fiscal(opts = {})
      required = [:GLAccountCode, :StartDate, :EndDate]
      check_required_parameters(required, opts)

      opts = { body:
                { sessionId: session_id,
                  administrationId: administration_id,
                  GLAccountCode: opts.fetch(:GLAccountCode),
                  StartDate: opts.fetch(:StartDate),
                  EndDate: opts.fetch(:EndDate)}
             }

      post('/GLAccountTransactionsFiscal', opts)
    end
  end
end
