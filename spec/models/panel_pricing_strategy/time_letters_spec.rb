require 'rails_helper'

RSpec.describe PanelPricingStrategy::TimeLetters, :type => :model do
  subject { described_class.new }

  describe "#call" do
    let(:parsed_uri) { double(URI::HTTP, open: content) }
    let(:content) do
      """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Maecenas dictum sodales orci sed posuere.
        In fringilla consequat viverra.
      """
    end

    before do
      allow(URI).to receive(:parse).and_return(parsed_uri)
    end

    it "parses provided url address" do
      expect(URI).to receive(:parse).with(described_class::URL)
      subject.call
    end

    it "loads Time magazine homepage" do
      expect(parsed_uri).to receive(:open)

      subject.call
    end

    it "returns the number of >>a<< letters divided by 100 as the price" do
      expect(subject.call).to eq(0.08)
    end
  end
end
