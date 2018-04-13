class ToppagesController < ApplicationController
  require 'json'
  require 'open-uri'
  require 'uri'
  
  def index
    unless logged_in?
      @images = []
      application_id = ENV['RAKUTEN_APPLICATION_ID']
    
      3.times do |i|
        random = rand(1..3)
        categoryId = 10 + i
        puts categoryId
        request_url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=#{application_id}&categoryId=#{categoryId}"
        mid_results = JSON.parse(open(request_url).read,{symbolize_names: true})
        if random == 1
          ranking = mid_results[:result].first
        elsif random == 2
          ranking = mid_results[:result].second
        else 
          ranking = mid_results[:result].third
        end
        @images.push(ranking[:foodImageUrl])
        sleep(0.88)
      end
    end
  end
  
  
  
end
