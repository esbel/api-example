module PanelPricingStrategy
  class TimeLetters
    URL = "http://time.com"

    def call(opts = {})
      Rails.cache.fetch("panel-price-#{self.class.to_s}", expires_in: 10.minutes) do
        uri = URI.parse(URL)
        file = uri.open.lines.to_a.join
        count = file.scan(/a/i).length

        count / 100.0
      end
    end
  end
end
