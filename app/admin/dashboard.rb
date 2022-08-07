# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
   

    # Here is an example of a simple dashboard with columns and panels.
    
    columns do
      column do
        panel "Recent product" do
          ul do
            Product.all.map do |post|
              li link_to(post.title, admin_product_path(post))
            end
          end
        end
      end

      column do
        panel "Category And Brands" do
          ul do 
            Category.all.each do |category|
              panel link_to(category.name,admin_category_path(category)) do 
                ul do
                  category.brands.each do |brand|
                    li link_to(brand.name,admin_brand_path(brand))
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
