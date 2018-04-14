class UsermenusController < ApplicationController
  def create
    @recipe = Recipe.find_or_initialize_by(code: params[:code])
    
    unless @recipe.persisted?

      @recipe.cost = setCost(params[:cost])
      @recipe.code = params[:code]
      @recipe.name = params[:name]
      @recipe.url = params[:url]
      @recipe.image_url = params[:imageUrl]
      
      p "******debug******"
      p @recipe.cost
      p @recipe.code
      p @recipe.name
      p @recipe.url
      p @recipe.image_url
      
      if @recipe.save
        p "セーブできた"
      end
    end
    
    if params[:type] == 'morning'
      current_user.cook(@recipe, 'morning', params[:cooked_day], params[:date], params[:food_type])
      flash[:success] = 'レシピを朝のメニューに登録しました。'
    elsif params[:type] == 'lunch'
      current_user.cook(@recipe, 'lunch', params[:cooked_day], params[:date], params[:food_type])
      flash[:success] = 'レシピを昼のメニューに登録しました。'
    else
      current_user.cook(@recipe, 'dinner', params[:cooked_day], params[:date], params[:food_type])
      flash[:success] = 'レシピを夜のメニューに登録しました。'
    end
   

    redirect_back(fallback_location: root_path)
  end
  
  def update
    @recipe = Recipe.find(params[:recipe_id])
    
      if params[:type] == 'morning'
        current_user.cooked(@recipe, 'morning', params[:cooked_day]) 
        flash[:success] = 'このレシピは作りました'
      elsif params[:type] == 'lunch'
        current_user.cooked(@recipe, 'lunch', params[:cooked_day]) 
        flash[:success] = 'このレシピは作りました'
      elsif params[:type] == 'dinner'
        current_user.cooked(@recipe, 'dinner', params[:cooked_day]) 
        flash[:success] = 'このレシピは作りました'
      end
    redirect_back(fallback_location: new_recipe_path)
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
      if params[:type] == 'morning'
        current_user.uncook(@recipe, 'morning') 
        flash[:success] = 'レシピを朝のメニューから外しました。'
      elsif params[:type] == 'lunch'
        current_user.uncook(@recipe, 'lunch') 
        flash[:success] = 'レシピを昼のメニューから外しました。'
      elsif params[:type] == 'dinner'
        current_user.uncook(@recipe, 'dinner') 
        flash[:success] = 'レシピを夜のメニューから外しました。'
      end
    redirect_back(fallback_location: root_path)
  end
end
