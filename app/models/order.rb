class Order < ApplicationRecord
    has_many :line_items ,dependent: :destroy
    belongs_to :user
    has_many :charges
    attr_writer :current_step
    def steps
      %w[user_order_detail user_address_detail confirmation]
    end
    def current_step
        @current_step || steps.first
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
end
