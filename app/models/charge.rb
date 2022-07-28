class Charge < ApplicationRecord
    belongs_to :user
    belongs_to :order
    attr_writer :current_step
    
    def current_step
        @current_step || steps.first
      end
      def steps
        %w[order_detail user_detail confirmation]
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
end
