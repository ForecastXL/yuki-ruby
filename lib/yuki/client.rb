require 'yuki/version'
require 'yuki/gl_accounts'
require 'active_support/all'

module Yuki
  class Client
    API_VERSION = '1'
    BASE_URI = 'https://api.yukiworks.nl/ws/Accounting.asmx'

    attr_accessor :api_version
    attr_accessor :session_id
    attr_accessor :administration_id
    attr_accessor :start_date
    attr_accessor :end_date

    def initialize(opts)
      required = [:access_key]
      check_required_parameters(required, opts)

      @access_key = opts[:access_key]
      self.administration_id = opts.fetch(:administration_id){ nil }
      @api_version = API_VERSION
    end

    def authenticate
      self.session_id = post('/Authenticate', { body: { accessKey: @access_key } })['string']
    end

    def administrations
      opts = { body: { sessionId: session_id } }
      response = post('/Administrations', opts)

      results = []
      unless response['Administrations'].nil?
        response['Administrations'].each do |administration|
          results << administration[1]
        end
      end

      results
    end

    def set_first_administration_id
      self.administration_id = administrations.first['ID']
    end

    def reconnect
      authenticate
    end

    def check_required_parameters(required, params)
      missing_params = required - params.keys
      params.fetch(required) { raise ArgumentError, "Missing required parameters: #{missing_params}" if missing_params.size > 0 }
    end

    private

    def get(path, opts)
      extract_response_body raw_get(path, opts)
    end

    def raw_get(path, opts)
      HTTParty.get("#{BASE_URI}#{path}", opts)
    end

    def post(path, opts)
      extract_response_body raw_post(path, opts)
    end

    def raw_post(path, opts)
      HTTParty.post("#{BASE_URI}#{path}", opts)
    end

    def delete(path)
      extract_response_body raw_delete(path)
    end

    def raw_delete(path)
      HTTParty.delete("#{BASE_URI}#{path}")
    end

    def extract_response_body(response)
      if response.code.in?(200..299)
        response.parsed_response
      else
        raise response
      end
    end
  end
end
