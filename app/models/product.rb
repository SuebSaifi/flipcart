class Product < ApplicationRecord
   belongs_to :user     
   has_one_attached :image
   has_many :product_categories,dependent: :destroy 
   has_many :categories 
   has_many :wishlists, dependent: :destroy
   has_many :carts
end