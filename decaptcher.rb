require 'net/http'
require 'net/https'
require "uri"

# Decaptcher module to decipher a captcha using decaptcher API
module Decaptcher
  def decipher_captcha(file)
    # decipher the captcha
    uri = URI.parse(AppConfig.decaptcher['url'])

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "multipart/form-data"

    request.set_form_data({ "function" => "picture2",
        "username" => AppConfig.decaptcher['username'],
        "password" => AppConfig.decaptcher['password'],
        "pict" => File.read(file),
        "pict_to" => '0',
        "pict_type" => '0' })

    http.request(request).body[-4,4]
  end
end