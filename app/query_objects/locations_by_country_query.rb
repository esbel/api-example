class LocationsByCountryQuery
  attr_accessor :country, :panel_provider

  def initialize(country)
    @country = country
  end

  def call
    @locations ||= Location.
      joins(:location_groups).
      where("location_groups.panel_provider_id" => country.panel_provider_id)
  end
end
