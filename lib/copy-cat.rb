require 'rubygems'
require 'vcr'
require 'sinatra'

set :port, 8848

class CopyCatServer < Sinatra::Base

  DEFAULT_HTTP_HEADERS = %w(Cookie x-csrftoken)

  get '*' do

    VCR.configure do |config|
      config.cassette_library_dir = settings.cassette_library_dir
      config.hook_into :webmock
    end

    content_type :json


    url_string = settings.base_url + request.path_info + "?" + request.query_string
    url = URI.parse(url_string)
    headers = {}

    http_headers = DEFAULT_HTTP_HEADERS + settings.custom_http_headers

    http_headers.each do |h|
      headers[h] = request.env["HTTP_#{h.upcase.gsub('-', '_')}"]
    end

    VCR.use_cassette(url) do
      http = Net::HTTP.new(url.host, url.port)

      resp = http.get(url.request_uri, headers)
      resp.body
    end

  end


end


class CopyCat

  def initialize args
    CopyCatServer.set :base_url, args[:base_url]
    CopyCatServer.set :custom_http_headers, args[:custom_http_headers] || []
    CopyCatServer.set :cassette_library_dir, args[:cassette_library_dir] || "fixtures/vcr_cassettes"
    # CopyCatServer.set :port, args[:port] || "8848"  # TODO: Not working
  end

  def start_server
    CopyCatServer.run!
  end

end