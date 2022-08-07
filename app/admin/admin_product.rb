ActiveAdmin.register Product do 
    permit_params :title,:price,:description,:image,:user_id,:category_id,:brand_id
    form do |f|
        f.hidden_field  :user_id,value: 2
        f.input :title
        f.input :description
        f.input :price
        # f.input :category,{Category.all }, as: :check_boxes, collection: proc 
        f.collection_select(:category_id, Category.all, :id, :name)
        f.collection_select(:brand_id, Brand.all, :id, :name)
        # adsf
        f.input :image, as: :file
        f.submit
    end
end
