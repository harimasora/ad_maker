# config/initializers/state_machine_patch.rb
# See https://github.com/pluginaweek/state_machine/issues/251
module StateMachine
  module Integrations
    module ActiveModel
      public :around_validation
    end
  end
end

module StateMachine
  module Integrations
    module ActiveRecord
      def define_state_initializer
        define_helper :instance, <<-end_eval, __FILE__, __LINE__ + 1
          def initialize(*)
            super do |*args|
              self.class.state_machines.initialize_states self
              yield(*args) if block_given?
            end
          end
        end_eval
      end
    end
  end
end