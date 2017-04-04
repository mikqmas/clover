require "net/http"
require "uri"
require 'json'

mid = "EJE2ZH35JJAG2"
employee = "RKGA7MJ6927WC"
auth_token = "e462d53f-0ef5-c500-65e9-350e7129ab73"

uri = URI.parse("https://sandbox.dev.clover.com/v3/merchants/#{mid}/employees/#{employee}/orders?filter=state=open&limit=1000")

request = Net::HTTP::Get.new(uri.request_uri)
request.add_field 'Authorization', 'Bearer ' + auth_token

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

response = http.request(request)

json = JSON.parse(response.body)

json["elements"].each do |el|
  id = el["id"]
  uri = URI.parse("https://sandbox.dev.clover.com/v3/merchants/#{mid}/orders/#{id}")
  request = Net::HTTP::Delete.new(uri.request_uri)
  request.add_field 'Authorization', 'Bearer ' + auth_token
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  response = http.request(request)
  print response.body

  sleep(0.5)
end
