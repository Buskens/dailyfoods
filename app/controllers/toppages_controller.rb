class ToppagesController < ApplicationController
  require 'json'
  require 'open-uri'
  require 'uri'
  require 'net/http'
  
  def index
    unless logged_in?
      @images = []
      application_id = ENV['RAKUTEN_APPLICATION_ID']
    
      3.times do |i|
        random = rand(1..5)
        categoryId = 10 + i
        puts categoryId
        request_url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=#{application_id}&categoryId=#{categoryId}"
        uri = URI.parse(request_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      mid_results = JSON.parse(res.body)
      #results = mid_results['result']
        #mid_results = JSON.parse(open(request_url).read,{symbolize_names: true})
        if random == 1
          ranking = mid_results['result'].first
        elsif random == 2
          ranking = mid_results['result'].second
        else 
          ranking = mid_results['result'].third
        end
        @images.push(ranking['foodImageUrl'])
        sleep(0.88)
      end
    end
  end
  
  
  
end
