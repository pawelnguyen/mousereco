class VisitorsController < InheritedResources::Base
  before_filter :authenticate_user!
end