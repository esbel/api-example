class LocationGroup < ActiveRecord::Base
  begin :associations
    belongs_to :country
    belongs_to :panel_provider

    has_and_belongs_to_many :locations
  end

  begin :validations
    validate :name,
      presence: true
  end
end
