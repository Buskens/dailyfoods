module UsersHelper
  def allCost()
    user = current_user
    cost = 0
    menu = Array.new

    menu = user.usermenus.all
    menu.each do |recipe|
      id = recipe.recipe_id
      cost += Recipe.find(id).cost
    end
    
    cost 
  end
  
  def weekCost()
    user = current_user
    cost = 0
    menu = Array.new

    menu = user.usermenus.all
    menu.each do |recipe|
      id = recipe.recipe_id
      cost += Recipe.find(id).cost
    end
    
    cost 
  end
  
end
