require 'rails_helper'

RSpec.describe PanelPricingStrategy::TimeNodes, :type => :model do
  subject { described_class.new }

  describe "#call" do
    let(:parsed_uri) { double(URI::HTTP, open: content) }
    let(:content) do
      """
        <html>
          <body>
            Lorem <i>ipsum</i> dolor sit amet, consectetur adipiscing elit.
            Maecenas dictum <strong>sodales</strong> orci sed posuere.
            In <u>fringilla</u> consequat <a href=\"http://ex.cc\">viverra</a>.
          </body>
        </html>
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

    it "calls Nokogiri::HTML with content" do
      expect(Nokogiri).to receive(:HTML).with(content).and_call_original

      subject.call
    end

    it "calls .css method on Nokogiri::HTML with * to get nodes count" do
      expect_any_instance_of(Nokogiri::HTML::Document).
        to receive(:css).
        with("*").
        and_call_original

      subject.call
    end

    it "returns the number of >>a<< letters divided by 100 as the price" do
      expect(subject.call).to eq(0.06)
    end
  end
end
