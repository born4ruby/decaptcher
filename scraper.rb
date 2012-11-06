require 'net/http'
require 'net/https'
require "uri"

module Scraper
  def egrul(search, captcha, cookie = '')
    # Fill and submit the remote form, then scrap the output.
    uri = URI.parse(AppConfig.scraper['egrul'])
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)

    request['Cookie'] = cookie
    request.set_form_data({ "num" => search['num'],
        "name" => search['name'],
        "address" => search['address'],
        "region" => search['region'],
        "date" => search['date'],
        "cc" => captcha,
        "action" => "SUBMIT" })

    http.request(request).body
  end
end