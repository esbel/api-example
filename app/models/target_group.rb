class TargetGroup < ActiveRecord::Base
  begin :associations
    belongs_to :country
    belongs_to :panel_provider
  end

  begin :validations
    validate :name,
      presence: true
  end
end
