class Country < ActiveRecord::Base
  begin :associations
    belongs_to :panel_provider

    has_many :location_groups
    has_many :target_groups, -> { roots }
  end

  begin :scopes
    scope :by_country_code, -> (code) { where(country_code: code) }
  end

  begin :validations
    validate :country_code,
      presence: true,
      uniqueness: true
  end
end
