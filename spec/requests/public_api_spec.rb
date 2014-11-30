require 'rails_helper'

RSpec.describe "Public API" do
  let(:countries) { double(take: country) }
  let(:country)   { double(Country, country_code: country_code) }

  before do
    allow(Country).
      to receive(:by_country_code).
      with(country.country_code).
      and_return(countries)
  end

  describe "/locations/:country_code" do
    let(:country_code) { "BLZ" }
    let(:query_object) { double(LocationsByCountryQuery, call: []) }

    before do
      allow(LocationsByCountryQuery).
        to receive(:new).
        and_return(query_object)
    end

    context "with known country" do
      it "calls the query object" do
        expect(query_object).to receive(:call)

        get "/locations/#{country_code}"
      end

      it "returns 200" do
        get "/locations/#{country_code}"

        expect(response.status).to eq(200)
      end

      it "provides JSON response" do
        get "/locations/#{country_code}"

        expect { JSON.parse(response.body) }.not_to raise_error
      end
    end

    context "with unknown country" do
      let(:invalid_country_code) { "MEX" }

      before do
        allow(Country).
          to receive(:by_country_code).
          and_return(double(take: nil))
      end

      it "returns 404" do
        get "/locations/#{invalid_country_code}"

        expect(response.status).to eq(404)
      end

      it "renders error response" do
        get "/locations/#{invalid_country_code}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).
          to eq({ "status" => 404, "message" => "Not Found."})
      end
    end
  end

  describe "/target_groups/:country_code" do
    let(:country_code) { "BLZ" }
    let(:query_object) { double(TargetGroupsByCountryQuery, call: []) }

    before do
      allow(TargetGroupsByCountryQuery).
        to receive(:new).
        and_return(query_object)
    end

    context "with known country" do
      it "calls the query object" do
        expect(query_object).to receive(:call)

        get "/target_groups/#{country_code}"
      end

      it "returns 200" do
        get "/target_groups/#{country_code}"
        expect(response.status).to eq(200)
      end

      it "provides JSON response" do
        get "/target_groups/#{country_code}"

        expect { JSON.parse(response.body) }.not_to raise_error
      end
    end

    context "with unknown country" do
      let(:invalid_country_code) { "MEX" }

      before do
        allow(Country).
          to receive(:by_country_code).
          and_return(double(take: nil))
      end

      it "returns 404" do
        get "/target_groups/#{invalid_country_code}"

        expect(response.status).to eq(404)
      end

      it "renders error response" do
        get "/target_groups/#{invalid_country_code}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).
          to eq({ "status" => 404, "message" => "Not Found."})
      end
    end
  end
end
