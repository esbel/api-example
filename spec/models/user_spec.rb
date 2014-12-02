require 'rails_helper'

RSpec.describe User, :type => :model do
  describe ".create!" do
    subject do
      described_class.create!(:email => "s@example.com", password: "password")
    end

    it "sets authentication token" do
      expect(subject.authentication_token).not_to be_empty
    end
  end
end
