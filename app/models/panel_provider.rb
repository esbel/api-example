class PanelProvider < ActiveRecord::Base
  begin :associations
    has_many :countries
    has_many :location_groups
  end

  begin :validations
    validate :code,
      presence: true
  end
end
