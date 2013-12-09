class Calculatable::Visit < ActiveRecord::Base
  PAGEVIEWS_MAX_OFFSET = 5.minutes.to_i
end
