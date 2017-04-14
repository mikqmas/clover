require "net/http"
require "uri"
require "json"

class MyApp
  attr_reader :request

  def initialize(request)
    @request = request
    @env = "apisandbox.dev" #Sandbox: apisandbox.dev US: https://api.clover.com EU: https://api.eu.clover.com
    @appSecret = "d8bac568-ed4e-eb8d-1706-e9788c147c4a" # found in developer dashboard, in the app's settings
  end

  def status
    if homepage?
      200
    else
      404
    end
  end

  def headers
    {'Content-Type' => 'text/html'}
  end

  def body
    if !@response
      @code = @request.params["code"]
      @client_id = @request.params["client_id"]
      @merchant_id = @request.params["merchant_id"]

      url = "https://#{@env}.clover.com/oauth/token?client_id=#{@client_id}&client_secret=#{@appSecret}&code=#{@code}"
      uri = URI.parse(url)
      request = Net::HTTP::Get.new(uri.request_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      @response = http.request(request)
      content = if homepage?
        "#{@response.body}"
      else
        "Page Not Found"
      end
      layout(content)
    end
  end

  def homepage?
    request.path_info == '/'
  end

  def layout(content)
%{<!DOCTYPE html>
<html lang="en">
  <head>

    <meta charset="utf-8">
    <title>Your IP</title>
  </head>
  <body>
    #{content}
  </body>
</html>}
  end
end

class MyApp::Rack
  def call(env)
    request = Rack::Request.new(env)
    my_app = MyApp.new(request)

    [my_app.status, my_app.headers, [my_app.body]]
  end
end

run MyApp::Rack.new
