class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  include RecipesHelper
  
  
  def read(result)
    code = result['recipeId']
    cost = result['recipeCost']
    name = result['recipeTitle']
    url = result['recipeUrl']
    image_url = result['mediumImageUrl']


    return {
      code: code,
      cost: cost,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
  
  def setCost(str)
    cstr = str.gsub(/\p{Han}/, "")
    cost = cstr.to_i
    return cost
  end

  def doneUpdate
    recipes = Usermenu.where("type != 'Done'")
    recipes.each do |recipe|
      if recipe.cooked_day < Date.today
        recipe.type = 'Done'
        recipe.updated_at = Time.zone.now 
        recipe.save
      end
    end
  end


  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
