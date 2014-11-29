class Location < ActiveRecord::Base

  begin :associations
    belongs_to :country
  end

  begin :validations
    validate :name,
      presence: true
  end
end
