class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #  include ActiveStorageSupport::SupportForBase64
  validates :first_name, presence: true
  validates :phone_number, presence: true
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  has_many :products
  has_one_attached :avatar
  attr_writer :current_step
  has_many :wishlists, dependent: :destroy
  has_many :carts
  has_many :orders
  def current_step
    @current_step || steps.first
  end
   
  def steps
    %w[user_detail buyer_saller_detail confirmation]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step) +1]
  end
  def pervious_step
      self.current_step = steps[steps.index(current_step) -1]
    end
  def first_step?
    current_step==steps.first
  end
  def last_step?
    current_step==steps.last
  end
  def second_step?
  current_step==steps[1]
end
  
  def to_s
    email
  end
  after_create do
    customer = Stripe::Customer.create(email:email)
    update(stripe_customer_id: customer.id)
  end
end
  