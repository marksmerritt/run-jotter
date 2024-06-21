class Run < ApplicationRecord
  include Activityable, Distanceable, Elevationable

  enum kind: %w[ easy_run long_run intervals hills fartlek ].index_by(&:itself)
end
