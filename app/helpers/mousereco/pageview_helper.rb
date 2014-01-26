module Mousereco
  module PageviewHelper
    def max_if_zero(value)
      value == 0 ? '100%' : value
    end
  end
end