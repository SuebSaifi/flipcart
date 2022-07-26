# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# AdminUser.create!(email: 'suebsaifi18@gmail.com', password: '123456', password_confirmation: '123456') if Rails.env.development?
Product.destroy_all
product1 = Product.create({:title=>"tomato", :price => 1})
product2 = Product.create({:title=>"milk", :price => 3})
product3 = Product.create({:title=>"bread", :price => 5.50})
product4 = Product.create({:title=>"bacon", :price => 10})
product5 = Product.create({:title=>"cheese", :price => 3.20})
puts "Total number of products: #{Product.all.count}"
puts "Product names: #{Product.all.pluck("title")}"
puts "Product1: #{product1.title} price: #{product1.price.round(2)}"
puts "Product2: #{product2.title} price: #{product2.price.round(2)}"
puts "Product3: #{product3.title} price: #{product3.price.round(2)}"
puts "Product4: #{product4.title} price: #{product4.price.round(2)}"
puts "Product5: #{product5.title} price: #{product5.price.round(2)}"
Cart.destroy_all
puts "\nTotal cart count: #{Cart.all.count}"