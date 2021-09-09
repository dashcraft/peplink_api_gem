require 'faraday'
require 'faraday_middleware'
require 'json'

module PeplinkApi
  class Client
    attr_reader :client_id, :org_id, :adapter, :access_token, :refresh_token
    def initialize(client_id:'', client_secret: '', org_id:'')
      @client_id = client_id
      @client_secret = client_secret
      @org_id = org_id
      @adapter = Faraday.default_adapter
    end

    def get_token
      body = {
        client_id: @client_id,
        client_secret: @client_secret,
        grant_type: "client_credentials"
      } 

      headers = {
        "Content-Type" => "application/x-www-form-urlencoded"
      }

      response = Faraday.post('https://api.ic.peplink.com/api/oauth2/token', body, headers)
      body = JSON.parse(response.body)
      @access_token = body["access_token"]
      @refresh_token = body["refresh_token"]
      
      create_v1_connection
      create_v2_connection
    end

    def create_v1_connection
      @v1_connection ||= Faraday.new do |conn|
        conn.headers = special_headers_with_auth
      end
      @v1_connection
    end

    def create_v2_connection
      @v2_connection ||= Faraday.new do |conn|
        conn.url_prefix = v2_base_url
        conn.headers = special_headers_with_auth
      end
      @v2_connection
    end

    def special_headers_with_auth
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{access_token}"
      }
    end

    def generic_headers_with_auth
      {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => "Bearer #{access_token}",
        'X-CSRF-API-TOKEN' =>
        '97296ad617850c380cfb832d31a3871a27f87c1a274c1f2e1db919db7e0306e085d5f697a6c21b22ad6606c2c4c9285106d00563c6d3ad8b8607b03879865c92'
      }
    end

    def v1_base_url
      "https://api.ic.peplink.com/rest/o/#{@org_id}"
    end

    def v2_base_url
      "https://api2.ic.peplink.com/rest/o/#{@org_id}"
    end

    def group_url(group_id)
      group_url = base_url + "/g/#{group_id}"
      group_url
    end

    def inspec
      "#<PeplinkApi::Client>"
    end

    def organization_devices
       url = "#{v1_base_url}"
       print url
       res = @v1_connection.get(url)
       print res
       JSON.parse(res.body)
    end

  end
end