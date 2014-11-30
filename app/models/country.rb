class Country < ActiveRecord::Base
  CODE_PATTERN = /\A[A-Z]{3}\z/

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
      format: { with: CODE_PATTERN },
      presence: true,
      uniqueness: true
  end
end
