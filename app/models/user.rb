class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :usermenus
  has_many :recipes, through: :usermenus
  
  has_many :mornings
  has_many :morning_recipes, through: :mornings, class_name: 'Recipe', source: :recipe
  
  has_many :lunches
  has_many :lunch_recipes, through: :lunches, class_name: 'Recipe', source: :recipe
  
  has_many :dinners
  has_many :dinner_recipes, through: :dinners, class_name: 'Recipe', source: :recipe
  
  def cook(recipe, type, cooked_day, date, food_type)
    if type == 'morning'
      cook = self.mornings.find_or_create_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.date = date
      cook.food_type = food_type
      cook.save
    elsif type == 'lunch'
      cook = self.lunches.find_or_create_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.date = date
      cook.food_type = food_type
      cook.save
    elsif type == 'dinner' 
      cook = self.dinners.find_or_create_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.date = date
      cook.food_type = food_type
      cook.save
    end
  end

  def uncook(recipe, type)
    if type == 'morning'
      cook = self.mornings.find_by(recipe_id: recipe.id)
      cook.destroy if cook
    elsif type == 'lunch'
      cook = self.lunches.find_by(recipe_id: recipe.id)
      cook.destroy if cook
    elsif type == 'dinner'
      cook = self.dinners.find_by(recipe_id: recipe.id)
      cook.destroy if cook
    end
  end



  def cooked(recipe, type, cooked_day)
    if type == 'morning'
      cook = self.mornings.find_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.type = 'Done'
      cook.save
    elsif type == 'lunch'
      cook = self.lunches.find_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.type = 'Done'
      cook.save
    elsif type == 'dinner'
      cook = self.dinners.find_by(recipe_id: recipe.id)
      cook.cooked_day = cooked_day
      cook.type = 'Done'
      cook.save
    end
  end

 
  def cook?(date, type, food_type)
    
    if type == 'morning' 
      result = self.mornings.where(cooked_day: date).where(food_type: food_type)
      result.empty?
    elsif type == 'lunch'
      result = self.lunches.where(cooked_day: date).where(food_type: food_type)
      result.empty?
    elsif type == 'dinner'
      result = self.dinners.where(cooked_day: date).where(food_type: food_type)
      result.empty?
    end 
  end
  


  def menuExist(date, type, food_type)
    
    if type == "morning"
      connection = self.mornings.where(cooked_day: date).where(food_type: food_type).first
      Recipe.find_by(id: connection.recipe_id).code
    elsif type == "lunch"
      connection = self.lunches.where(cooked_day: date).where(food_type: food_type).first
      Recipe.find_by(id: connection.recipe_id).code
    elsif type == "dinner"
      connection = self.dinners.where(cooked_day: date).where(food_type: food_type).first
      Recipe.find_by(id: connection.recipe_id).code
    end
    
  end
  

  def datecost(date)
    cost = 0
    menus = self.usermenus.where(cooked_day: date)
    unless menus.nil? 
      menus.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
      cost
    end
  end
  
  def monthcost(month)
    cost = 0
    menus = self.usermenus.where('cooked_day >= ?', month).where('cooked_day <= ?', month.end_of_month)
    unless menus.nil? 
      menus.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
      cost
    end
  end
  
  def yearcost(year)
    cost = 0
    menus = self.usermenus.where('cooked_day >= ?', year).where('cooked_day <= ?', year.end_of_year)
    unless menus.nil? 
      menus.each do |recipe|
        id = recipe.recipe_id
        cost += Recipe.find(id).cost
      end
      cost
    end
  end
  
end
