class LineItem < ActiveRecord::Base
    belongs_to :product
    belongs_to :cart, optional: true
    belongs_to :order ,optional: true
    def total_price
      self.quantity * self.product.price
    end
    def to_builder
      Jbuilder.new do |product|
         product.price self.product.stripe_price_id
         product.quantity self.quantity
      end
    end
end
