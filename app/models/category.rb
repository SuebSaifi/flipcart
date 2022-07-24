class Category < ApplicationRecord
    has_many :categories_product
    has_many :products ,through: :categories_product
end
