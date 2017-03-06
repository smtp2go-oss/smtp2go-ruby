$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "smtp2go"

def fake_response
  net_http_resp = Net::HTTPResponse.new(1.0, '200', "OK")
  net_http_resp.body = {
    "data"=>{
      "failures"=>[],
      "succeeded"=>1,
      "failed"=>0
    },
    "request_id"=>"4143a82e-0214-11e7-b3d0-f23c91285f72"
  }
end
