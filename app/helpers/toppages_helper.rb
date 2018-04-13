module ToppagesHelper
  
  def costSet(type, date)
    user = current_user
    cost = 0
    menu = Array.new
    if type == 'morning' 
      menu = user.mornings.where(cooked_day: date)
    elsif type == 'lunch'
      menu = user.lunches.where(cooked_day: date)
    elsif type == 'dinner'
      menu = user.dinners.where(cooked_day: date)
    end

    if menu.nil? 
      cost
    else
      menu.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
      cost
    end
    
  end
  
  
  def allCostSet(date)
    user = current_user
    cost = 0
    menu = Array.new
    
    menu = user.mornings.where(cooked_day: date)
    unless menu.nil? 
      menu.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
    end
    
    menu = user.lunches.where(cooked_day: date)
    unless menu.nil? 
      menu.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
    end
    
    menu = user.dinners.where(cooked_day: date)

    if menu.nil? 
      cost
    else
      menu.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
      cost
    end
  end
  
  
  def randomImage(categoryId)
    require 'open-uri'
    require 'uri'
    require 'json'
    random = rand(1..3)
    
    application_id = ENV['RAKUTEN_APPLICATION_ID']
    request_url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?format=json&categoryId=#{categoryId}&applicationId=#{application_id}"
    mid_results = JSON.parse(open(request_url).read,{symbolize_names: true})
    if random == 1
      result = mid_results[:result].first
    elsif random == 2
      result = mid_results[:result].second
    else 
      result = mid_results[:result].third
    end
    
    result[:foodImageUrl]
    sleep(0.5)
  end
  
  def datedeterm(date)
    youbi = %w(Mon Tue Wed Thu Fri Sat Sun)[date.to_date.cwday - 1]
    youbi 
  end
  
  def menuExist?(date, type, food_type)
    result = current_user.user_menus.where(date: date).where(type: type).where(food_type: food_type)
    result.empty?
  end
  
  def miniThumbNail(date, type, food_type)
    result = current_user.user_menus.where(date: date).where(type: type).where(food_type: food_type)
    id = result.first.recipe_id
    image_url = Recipe.find_by(id: id).image_url
    url = Recipe.find_by(id: id).url
    return url, image_url
  end
  
  def dayWeek(date)
    youbi = %w(Mon Tue Wed Thu Fri Sat Sun)[date.to_date.cwday - 1]
    
    case youbi
    when "Mon" then
      youbi = "月"
      youbi
    when "Tue" then
      youbi = "火"
      youbi
    when "Wed" then
      youbi = "水"
      youbi
    when "Thu" then
      youbi = "木"
      youbi
    when "Fri" then
      youbi = "金"
      youbi
    when "Sat" then
      youbi = "土"
      youbi
    when "Sun" then
      youbi = "日"
      youbi
    end 
    
  end 
  
end
