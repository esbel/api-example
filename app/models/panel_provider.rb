class PanelProvider < ActiveRecord::Base
  begin :associations
    has_many :countries
    has_many :location_groups
    has_many :target_groups
  end

  begin :validations
    validate :code,
      presence: true
  end
end
