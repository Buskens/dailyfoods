class RecipesController < ApplicationController
  require 'uri'
  require 'json'
  require 'net/http'
  
  before_action :require_user_logged_in
  before_action :doneUpdate
  
  def new
    @recipes = []
    
    category_id = params[:category_id]
    application_id = ENV['RAKUTEN_APPLICATION_ID']

    puts "*****debug****************"
    category_id.each do |request_id|
      p request_id
      request_url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?format=json&categoryId=#{request_id}&applicationId=#{application_id}"
      uri = URI.parse(request_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      req = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(req)
      mid_results = JSON.parse(res.body)
      results = mid_results['result']
      results.each do |result|
        recipes = Recipe.new(read(result))
        @recipes << recipes
      end
      sleep(0.88)
    end
  end
end
