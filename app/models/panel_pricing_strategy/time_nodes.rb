require 'open-uri'

module PanelPricingStrategy
  class TimeNodes
    URL = "http://time.com"

    def call(opts = {})
      Rails.cache.fetch("panel-price-#{self.class.to_s}", expires_in: 10.minutes) do
        uri = URI.parse(URL)

        doc = Nokogiri::HTML(uri.open)
        tag_count = doc.css("*").length

        tag_count / 100.0
      end
    end
  end
end
