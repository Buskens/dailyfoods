class Recipe < ApplicationRecord
  validates :code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :cost, presence: true
  
  has_many :usermenus
  has_many :users, through: :usermenus
  
  has_many :mornings
  has_many :morning_users, through: :mornings, class_name: 'User', source: :user
  
  has_many :lunches
  has_many :lunch_users, through: :lunches, class_name: 'User', source: :user
  
  has_many :dinners
  has_many :dinner_users, through: :dinners, class_name: 'User', source: :user
end
