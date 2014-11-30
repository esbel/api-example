require 'rails_helper'

RSpec.describe CalculatePrice, :type => :service_object do
  let(:country)      { double(Country) }
  let(:locations)    { double("locations_list") }
  let(:target_group) { double(TargetGroup) }

  subject { described_class.new(country, target_group, locations) }

  describe ".new" do
    it "assigns country" do
      expect(subject.country).to eq(country)
    end

    it "assigns locations" do
      expect(subject.locations).to eq(locations)
    end

    it "assigns target_group" do
      expect(subject.target_group).to eq(target_group)
    end
  end

  describe "#call" do
    let(:a_location)          { { "id" => 123, "panel_size" => panel_size } }
    let(:locations)           { [ a_location ] }
    let(:location_groups)     { [ location_group ] }
    let(:panel_provider_code) { double }
    let(:panel_size)          { 200 }
    let(:price)               { 42 }
    let(:panel_provider_code) { "TimeLetters" }
    let(:location) do
      double(Location, location_groups: location_groups)
    end
    let(:location_group) do
      double(LocationGroup, panel_provider: panel_provider)
    end
    let(:panel_provider) do
      double(PanelProvider,
        code: panel_provider_code
      )
    end

    before do
      allow(PanelProvider).to receive(:find_by_code).and_return(panel_provider)
      allow(Location).to      receive(:find).and_return(location)

      allow_any_instance_of(PanelPricingStrategy::TimeLetters).
        to receive(:call).and_return(price)
      allow_any_instance_of(PanelPricingStrategy::AjaxNodes).
        to receive(:call).and_return(price)
      allow_any_instance_of(PanelPricingStrategy::TimeNodes).
        to receive(:call).and_return(price)
    end

    shared_examples_for "calling pricing strategy" do
      it "calls provided klass to get price" do
        expect_any_instance_of(klass).to receive(:call)

        subject.call
      end
    end

    it "calculates the prices" do
      expect(subject.call).to eq(price * panel_size)
    end

    it "searches for Location with given id" do
      expect(Location).to receive(:find).with(a_location["id"])

      subject.call
    end

    context "with more than one location" do
      let(:locations) { [ a_location, a_location ] }

      it "calculates the price as sum" do
        expect(subject.call).to eq(price * panel_size * locations.length)
      end
    end

    context "when PanelProvider code is TimeLetters" do
      let(:panel_provider_code) { "TimeLetters" }
      let(:klass) { PanelPricingStrategy::TimeLetters }

      it_behaves_like "calling pricing strategy"
    end

    context "when PanelProvider code is AjaxNodes" do
      let(:panel_provider_code) { "AjaxNodes" }
      let(:klass) { PanelPricingStrategy::AjaxNodes }

      it_behaves_like "calling pricing strategy"
    end

    context "when PanelProvider code is TimeNodes" do
      let(:panel_provider_code) { "TimeNodes" }
      let(:klass) { PanelPricingStrategy::TimeNodes }

      it_behaves_like "calling pricing strategy"
    end
  end
end
