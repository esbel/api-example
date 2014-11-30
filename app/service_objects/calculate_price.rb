class CalculatePrice
  attr_accessor :country, :target_group, :locations

  def initialize(country, target_group, locations)
    @country, @target_group, @locations = country, target_group, locations
  end

  def call
    # collect panel providers
    panels = locations.map do |l|
      [
        Location.find(l["id"]).location_groups.collect(&:panel_provider),
        l["panel_size"].to_i
      ]
    end

    # collect prices
    prices = panels.map do |panel, size|
      pricing_strategy_for(panel.first).new.call * size
    end

    # sum
    prices.sum
  end

  private
  def pricing_strategy_for(panel)
    case panel.code
    when "TimeLetters"
      PanelPricingStrategy::TimeLetters
    when "AjaxNodes"
      PanelPricingStrategy::AjaxNodes
    when "TimeNodes"
      PanelPricingStrategy::TimeNodes
    end
  end
end
