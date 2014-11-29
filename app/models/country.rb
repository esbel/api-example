class Country < ActiveRecord::Base
  begin :associations
    belongs_to :panel_provider
  end

  begin :scopes
    scope :by_country_code, -> (code) { where(country_code: code) }
  end

  begin :validations
    validate :country_code,
      presence: true
  end
end
