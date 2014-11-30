require 'rails_helper'

RSpec.describe "Public API" do
  describe "/locations/:country_code" do
    let(:country_code) { "BLZ" }

    it "returns 200" do
      get "/locations/#{country_code}"

      expect(response.status).to eq(200)
    end

    it "returns 200" do
      get "/locations/#{country_code}"

      expect(response.status).to eq(200)
    end
  end

  describe "/target_groups/:country_code" do
    let(:country_code) { "BLZ" }

    it "returns 200" do
      get "/target_groups/#{country_code}"

      expect(response.status).to eq(200)
    end
  end
end
