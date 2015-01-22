require "yuki_api_wrapper/version"

module YukiApiWrapper
  class Client
    API_VERSION = '1'
    BASE_URI = 'https://api.yukiworks.nl/ws/Accounting.asmx'

    attr_accessor :api_version
    attr_accessor :session_id
    attr_accessor :administration_id

    # https://api.yukiworks.nl/ws/Accounting.asmx
    # Administratie ForecastXL 
    # Administratiecode 29a885ea-5928-41a8-8e5f-424cdf217a54 
    # Toegangscode d7895de9-56ba-41be-a9a9-51e0fb699451

    def initialize(opts)
      required = [:access_key]
      check_required_parameters(required, opts)

      @access_key = opts[:access_key]
      @api_version = API_VERSION
    end

    def authenticate
      response = post('/Authenticate', { body: { accessKey: @access_key }})
      self.session_id = response["string"]
    end

    def administrations
      opts = { body: { sessionId: self.session_id }}
      post('/Administrations', opts)
    end

    def set_first_administration_id
      self.administration_id = self.administrations['Administrations']['Administration']['ID']
    end

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

    def reconnect
      authenticate
    end

    def check_required_parameters(required, params)
      params.fetch(required) { raise ArgumentError, "Missing required parameters: #{required - params.keys}" if (required-params.keys).size > 0 }
    end


    private
      def get(path, opts)
        extract_response_body raw_get(path, opts)
      end

      def raw_get(path, opts)
        uri = BASE_URI+path
        p "Getting #{uri}"
        HTTParty.get(uri, opts)
      end

      def post(path, opts)
        extract_response_body raw_post(path, opts)
      end

      def raw_post(path, opts)
        uri = BASE_URI+path
        p "Posting to #{uri}"
        HTTParty.post(uri, opts)
      end

      def delete(path)
        extract_response_body raw_delete(path)
      end

      def raw_delete(path)
        uri = BASE_URI+path
        HTTParty.delete(uri)
      end

      def extract_response_body(resp)
        resp.parsed_response
      end
  end
end


