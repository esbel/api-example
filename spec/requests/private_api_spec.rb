require 'rails_helper'

RSpec.describe "Public API" do
  let(:countries)     { double(take: country) }
  let(:target_groups) { double(find: []) }
  let(:country) do
    double(Country, country_code: country_code, target_groups: target_groups)
  end

  before do
    allow(Country).
      to receive(:by_country_code).
      with(country.country_code).
      and_return(countries)
  end

  shared_examples_for "not_found_response" do
      before do
        allow(Country).
          to receive(:by_country_code).
          and_return(double(take: nil))
      end

      it "returns 404" do
        get url

        expect(response.status).to eq(404)
      end

      it "renders error response" do
        get url
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).
          to eq({ "status" => 404, "message" => "Not Found."})
      end
  end

  describe "GET /locations/:country_code" do
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
      let(:url)                  { "/locations/#{invalid_country_code}" }

      it_behaves_like "not_found_response"
    end
  end

  describe "GET /target_groups/:country_code" do
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
      let(:url)                  { "/target_groups/#{invalid_country_code}" }

      it_behaves_like "not_found_response"
    end
  end

  describe "POST /evaluate_target" do
    let(:country_code)    { "SLV" }
    let(:target_group)    { double(TargetGroup, id: target_group_id) }
    let(:target_group_id) { "42" }
    let(:target_groups)   { double(find: target_group) }
    let(:location_id)     { "32" }
    let(:panel_size)      { "200" }
    let(:service_object)  { double(CalculatePrice, call: price) }
    let(:price)           { 2000 }
    let(:locations)       { [ { id: location_id, panel_size: panel_size } ] }
    let(:request_data) do
      {
        country_code:    country_code,
        target_group_id: target_group_id,
        locations:       locations,
      }
    end

    before do
      allow(CalculatePrice).to receive(:new).and_return(service_object)
    end

    context "with valid params" do
      it "initializes CalculatePrice service object with params" do
        locations_array = locations.map { |loc| Hashie::Mash.new(loc) }

        expect(CalculatePrice).
          to receive(:new).
          with(country, target_group, locations_array)

        post "evaluate_target", request_data
      end

      it "calls CalculatePrice service object to get price" do
        expect(service_object).to receive(:call)

        post "evaluate_target", request_data
      end

      it "returns the price" do
        post "evaluate_target", request_data
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to eq({"price" => price})
      end

      it "returns HTTP 201 created" do
        post "evaluate_target", request_data

        expect(response.status).to eq(201)
      end
    end
  end
end
