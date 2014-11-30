require 'rails_helper'

RSpec.describe TargetGroupsByCountryQuery, :type => :service_object do
  let(:country) { double(Country) }

  subject { described_class.new(country) }

  describe ".new" do
    it "assigns country" do
      expect(subject.country).to eq(country)
    end
  end

  describe "#call" do
    let(:country)       { double(Country, panel_provider_id: panel_id) }
    let(:panel_id)      { double }
    let(:query_result)  { double }

    before do
      allow(TargetGroup).to receive(:where).and_return(query_result)
    end

    it "queries TargetGroup by panel_id" do
      expect(TargetGroup).
        to receive(:where).
        with(panel_provider_id: panel_id)

      subject.call
    end

    it "returns the query result" do
      expect(subject.call).to eq(query_result)
    end
  end
end
