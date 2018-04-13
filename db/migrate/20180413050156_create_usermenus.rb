class CreateUsermenus < ActiveRecord::Migration[5.0]
  def change
    create_table :usermenus do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.string :date
      t.string :food_type
      t.date :cooked_day

      t.timestamps
      
      t.index [:user_id, :recipe_id , :type], unique: true
    end
  end
end
