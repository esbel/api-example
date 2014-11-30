require 'rails_helper'

RSpec.describe PanelPricingStrategy::AjaxNodes, :type => :model do
  subject { described_class.new }

  describe "#call" do
    let(:parsed_uri) { double(URI::HTTP, open: response) }
    let(:response) do
      "{\"responseData\": {\"query\":\"news\",\"entries\":[{\"url\":\"http://news.google.com/news?pz\\u003d1\\u0026cf\\u003dall\\u0026ned\\u003dus\\u0026hl\\u003den\\u0026topic\\u003dh\\u0026num\\u003d3\\u0026output\\u003drss\",\"title\":\"Google \\u003cb\\u003eNews\\u003c/b\\u003e\",\"contentSnippet\":\"Comprehensive up-to-date \\u003cb\\u003enews\\u003c/b\\u003e coverage, aggregated from sources all over the \\u003cbr\\u003e\\nworld by Google \\u003cb\\u003eNews\\u003c/b\\u003e.\",\"link\":\"http://news.google.com/\"}]}, \"responseDetails\": null, \"responseStatus\": 200}"
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

    it "parses the JSON response (to process encoded entities)" do
      expect(JSON).to receive(:parse).with(response).and_call_original

      subject.call
    end

    it "calls Nokogiri::HTML with a string" do
      expect(Nokogiri).
        to receive(:HTML).
        with(a_kind_of(String)).
        and_call_original

      subject.call
    end

    it "uses Nokogiri document to obtain number of b tags" do
      expect_any_instance_of(Nokogiri::HTML::Document).
        to receive("css").
        with("b").
        and_call_original

      subject.call
    end

    it "returns the price sum values as the price" do
      expect(subject.call).to eq(3)
    end
  end
end
