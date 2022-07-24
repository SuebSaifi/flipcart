ActiveAdmin.register Product do 
    permit_params :title,:price,:description,:image,:user_id,:category_ids=>[]
    form do |f|
        f.input :user_id
        f.input :title
        f.input :description
        f.input :price
        # f.input :category,{Category.all }, as: :check_boxes, collection: proc 
        f.input :category_ids, as: :check_boxes,collection: Category.all, prompt: "Select Category", input_html: { class: "form-control center" }
        # adsf
        f.input :image, as: :file
        f.submit
    end
    
end
