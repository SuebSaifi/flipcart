class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #  include ActiveStorageSupport::SupportForBase64

  # has_one_attached :profile_image
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  # has_one_attached :profile_image
  attr_writer :current_step
  has_many :wishlists, dependent: :destroy
  has_many :carts
  def current_step
    @current_step || steps.first
  end
   
  def steps
    %w[user_detail buyer_saller_detail confirmation]
  end
  
  def next_step
  # debugger
    self.current_step = steps[steps.index(current_step) +1]
  end
  def pervious_step
    # debugger
      self.current_step = steps[steps.index(current_step) -1]
    end
  def first_step?
    current_step==steps.first
  end
  def last_step?
    current_step==steps.last
  end
end
