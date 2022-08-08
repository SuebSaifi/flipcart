class Product < ApplicationRecord
   belongs_to :user
   has_one_attached :image
   has_many :wishlists, dependent: :destroy
   has_many :categories_product 
   has_many :categories ,through: :categories_product
   has_many :orders
   belongs_to :brand
   has_many :reviews ,dependent: :destroy
   has_many :ratings ,dependent: :destroy
   after_create do
      product=Stripe::Product.create(name: title)
      price = Stripe::Price.create(product: product,unit_amount: self.price.to_i*100,currency:"inr")
      update(stripe_product_id: product.id,stripe_price_id: price.id)
   end
   
   def product_rating
      rate = self.ratings.pluck("rating")
      average_rating = rate.sum/((rate.size).to_f).round(1) 
      p average_rating
   end
   def product_rating_count
      self.ratings.pluck("rating").count
   end
   def product_review_count
      self.reviews.count
   end
end      