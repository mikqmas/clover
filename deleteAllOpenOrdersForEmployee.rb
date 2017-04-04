require "net/http"
require "uri"
require 'json'

env = "sandbox.dev.clover.com" # or api.clover.com for production
mid = #merchant id
employee = #employee id
auth_token = #oauth or merchant token

uri = URI.parse("https://#{env}/v3/merchants/#{mid}/employees/#{employee}/orders?filter=state=open&limit=1000")

request = Net::HTTP::Get.new(uri.request_uri)
request.add_field 'Authorization', 'Bearer ' + auth_token

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

response = http.request(request)

json = JSON.parse(response.body)

json["elements"].each do |el|
  id = el["id"]
  uri = URI.parse("https://#{env}/v3/merchants/#{mid}/orders/#{id}")
  request = Net::HTTP::Delete.new(uri.request_uri)
  request.add_field 'Authorization', 'Bearer ' + auth_token
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  response = http.request(request)
  print response.body

  sleep(0.5)
end
