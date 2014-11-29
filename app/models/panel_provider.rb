class PanelProvider < ActiveRecord::Base
  KNOWN_PROVIDER_CODES = [ "TimeLetters", "AjaxNodes", "TimeNodes" ]

  begin :associations
    has_many :countries
    has_many :location_groups
    has_many :target_groups
  end

  begin :validations
    validate :code,
      inclusion: { in: KNOWN_PROVIDER_CODES },
      presence: true
  end
end
