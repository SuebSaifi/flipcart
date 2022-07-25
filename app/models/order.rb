class Order < ApplicationRecord
    belongs_to :carts ,:class_name => "Carts"
end
