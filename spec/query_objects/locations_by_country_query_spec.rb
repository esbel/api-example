require 'rails_helper'

RSpec.describe LocationsByCountryQuery, :type => :service_object do
  let(:country) { double(Country) }

  subject { described_class.new(country) }

  describe ".new" do
    it "assigns country" do
      expect(subject.country).to eq(country)
    end
  end

  describe "#call" do
    let(:country)       { double(Country, panel_provider_id: panel_id) }
    let(:joined_tables) { double(where: query_result) }
    let(:panel_id)      { double }
    let(:query_result)  { double }

    before do
      allow(Location).to receive(:joins).and_return(joined_tables)
    end

    it "joins Location and LocationGroups" do
      expect(Location).to receive(:joins).with(:location_groups)

      subject.call
    end

    it "queries joined tables by panel_id" do
      expect(joined_tables).
        to receive(:where).
        with("location_groups.panel_provider_id" => panel_id)

      subject.call
    end

    it "returns the query result" do
      expect(subject.call).to eq(query_result)
    end
  end
end
