class LocationGroup < ActiveRecord::Base
  begin :associations
    belongs_to :country

    has_and_belongs_to_many :locations
  end

  begin :validations
    validate :name,
      presence: true
  end
end
