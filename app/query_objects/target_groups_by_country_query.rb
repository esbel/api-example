class TargetGroupsByCountryQuery
  attr_accessor :country, :panel_provider

  def initialize(country)
    @country = country
  end

  def call
    @target_groups ||= TargetGroup.
      where(panel_provider_id: @country.panel_provider_id)
  end
end
