class Review < ApplicationRecord
    belongs_to :user
    belongs_to :product
    # belongs_to :parent ,class_name:"Review",optional: true
    # has_many :reply,class_name:"Review" , foreign_key: :parent_id,dependent: :destroy
    has_many :replies , dependent: :destroy
end