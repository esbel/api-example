require 'rails_helper'

RSpec.describe Country, :type => :model do
  describe ".by_country_code" do
    let!(:country)         { described_class.create(:country_code => "PAN") }
    let!(:another_country) { described_class.create(:country_code => "NIC") }

    it "includes country with matching code" do
      expect(described_class.by_country_code("PAN")).
        to include(country)
    end

    it "doesn't include another countries with matching code" do
      expect(described_class.by_country_code("PAN")).
        not_to include(another_country)
    end
  end
end
