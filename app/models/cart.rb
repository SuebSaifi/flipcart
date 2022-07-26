class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :product
    def current_user_cart
        "cart#{id}"
    end
    def total_count
        cat=0
        user.carts.map do |cart|
        cat=cat+cart.product.price
    end
    cat
    end
  
end
