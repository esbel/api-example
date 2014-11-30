module PanelPricingStrategy
  class AjaxNodes
    URL = "https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news"

    def call(opts = {})
      Rails.cache.fetch("panel-price-#{self.class.to_s}", expires_in: 10.minutes) do
        uri = URI.parse(URL)
        file = uri.open.lines.to_a.join
        json_data = JSON.parse(file)

        values = json_data["responseData"]["entries"].collect do |entry|
          entry_doc = Nokogiri::HTML(entry["title"] + entry["contentSnippet"])
          entry_doc.css("b").length
        end

        values.sum
      end
    end
  end
end
