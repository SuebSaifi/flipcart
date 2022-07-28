class OrdersProduct < ApplicationRecord
    belongs_to :current_order
    belongs_to :product
end