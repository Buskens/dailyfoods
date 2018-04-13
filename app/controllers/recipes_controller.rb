class RecipesController < ApplicationController
  require 'open-uri'
  require 'uri'
  require 'json'
  
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
      mid_results = JSON.parse(open(request_url).read,{symbolize_names: true})
      results = mid_results[:result]
      results.each do |result|
        recipes = Recipe.new(read(result))
        @recipes << recipes
      end
      sleep(0.88)
    end
  end
end
