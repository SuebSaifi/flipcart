class Product < ApplicationRecord
   belongs_to :user     
   has_one_attached :image
   has_many :wishlists, dependent: :destroy
   has_many :categories_product 
   has_many :categories ,through: :categories_product
   has_many :orders
   
   def do_bulder
      Jbulder.new do |product|
         product.price stripe_price_id
         product.quantity 1
      end
   end
   after_create do
      product=Stripe::Product.create(name: title)
      price = Stripe::Price.create(product: product,unit_amount: self.price.to_i*100,currency:"inr")
      update(stripe_product_id: product.id)
   end

end