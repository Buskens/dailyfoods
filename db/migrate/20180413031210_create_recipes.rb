class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :code
      t.string :name
      t.string :url
      t.string :image_url
      t.integer :cost

      t.timestamps
    end
  end
end
