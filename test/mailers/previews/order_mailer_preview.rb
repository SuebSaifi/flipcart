# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_created
  def order_created
     OrderMailer.with(user:User.first,order:Order.first).order_created
  end

end
