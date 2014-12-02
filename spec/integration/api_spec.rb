require 'rails_helper'

RSpec.describe "API" do
  let!(:country) do
    Country.create!({
      country_code: "BLZ",
      panel_provider_id: panel_provider.id
    })
  end
  let!(:another_country) do
    Country.create!({
      country_code: "HND",
      panel_provider_id: another_panel_provider.id
    })
  end
  let!(:panel_provider)         { PanelProvider.create!(code: "TimeLetters") }
  let!(:another_panel_provider) { PanelProvider.create!(code: "AjaxNodes") }
  let!(:target_group)           { TargetGroup.create!(name: "Sample group") }
  let!(:location) do
    Location.create!({
      name: "Belize City",
      country_id: country.id
    })
  end
  let!(:another_location) do
    Location.create!({
      name: "Apopa",
      country_id: another_country.id
    })
  end
  let!(:location_group) do
    location_group = LocationGroup.create!({
      name: "Some cities",
      country_id: country.id,
      panel_provider_id: panel_provider.id
    })
    location_group.locations << location
    location_group
  end
  let!(:another_location_group) do
    location_group = LocationGroup.create!({
      name: "Some other cities",
      country_id: another_country.id,
      panel_provider_id: another_panel_provider.id
    })
    location_group.locations << another_location
    location_group
  end
  let!(:target_group) do
    TargetGroup.create!({
       name: "Group A",
       country_id: country.id,
       panel_provider_id: panel_provider.id
      })
  end
  let!(:another_target_group) do
    TargetGroup.create!({
       name: "Group B",
       country_id: another_country.id,
       panel_provider_id: another_panel_provider.id
      })
  end

  describe "GET /locations/:country_code" do
    it "returns serialized array of locations" do
      get "/locations/BLZ"
      parsed_response= JSON.parse(response.body)

      expected_response = {
        "locations" => [{"id"=>location.id, "name"=>"Belize City"}]
      }
      expect(parsed_response).to eq(expected_response)
    end
  end

  describe "GET /target_groups/:country_code" do
    it "returns serialized array of target groups" do
      get "/target_groups/BLZ"
      parsed_response= JSON.parse(response.body)

      expected_response = {
        "target_groups" =>
          [{ "id" => target_group.id, "name" => "Group A", "parent_id" => nil}]
      }
      expect(parsed_response).to eq(expected_response)
    end
  end

  describe "POST /evaluate_target" do
    let(:token) { "sample-token" }
    let(:request_parameters) do
      {
        country_code:    "BLZ",
        target_group_id: target_group.id,
        locations:       [
          { id: location.id,         panel_size: 300 },
          { id: another_location.id, panel_size: 200 },
        ],
        access_token: token
      }
    end
    let!(:user) do
      User.create!({
        authentication_token: token,
        email: "my.email@example.com",
        password: "empty-passwd"
      })
    end

    before do
      VCR.insert_cassette "pricing_data_requests"
    end

    after do
      VCR.eject_cassette "pricing_data_requests"
    end

    context "with valid token" do
      it "returns serialized array of target groups" do
        post "/evaluate_target", request_parameters
        parsed_response = JSON.parse(response.body)

        expected_response = { "price" => 30592.0 }
        expect(parsed_response).to eq(expected_response)
      end
    end

    context "with invalid token" do
      let(:invalid_token) { "invalid-token" }

      it "returns error response" do
        post "/evaluate_target",
          request_parameters.clone.merge(access_token: invalid_token)

        expect(response.status).to eq(401)
      end
    end
  end
end
