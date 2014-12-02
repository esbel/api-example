require 'rails_helper'

RSpec.describe AuthenticationHelpers, type: :helper do
  let(:dummy_class) do
    class DummyClass
      include AuthenticationHelpers

      def env; {"warden" => @warden}; end
      def error!(a,b); end
      def params; { "access_token" => "sample-token" }; end
    end

    DummyClass
  end

  subject do
    dummy_class.new
  end

  before do
    subject.instance_variable_set("@warden", double(user: double))
  end

  describe "#authenticated" do
    before do
      subject.instance_variable_set("@warden",
        double(user: double, authenticated?: authenticated))
    end

    context "when authenticated" do
      let(:authenticated) { true }

      it "returns true" do
        expect(subject.authenticated).to eq(true)
      end
    end

    context "when not authenticated" do
      let(:authenticated) { false }

      before do
        allow(User).
          to receive(:find_by_authentication_token).
          and_return(user)
      end

      context "with valid authentication_token" do
        let(:user) { double(User) }

        it "returns true" do
          expect(subject.authenticated).to eq(user)
        end
      end

      context "with invalid authentication_token" do
        let(:user)          { nil }

        it "returns false" do
          expect(subject.authenticated).to eq(nil)
        end
      end
    end
  end

  describe "#current_user" do
    context "when warden.user exists" do
      it "returns the warden user" do
        expect(subject.current_user).to eq(subject.env["warden"].user)
      end
    end

    context "when warden.user does not exist" do
      let(:user)          { nil }
      let(:instance_user) { double(User) }

      before do
        subject.instance_variable_set("@warden", double(user: nil))
        subject.instance_variable_set("@user", instance_user)
      end

      it "returns user from instance variable" do
        expect(subject.current_user).to eq(instance_user)
      end
    end
  end

  describe "#unauthorized!" do
    it "calls rack_response with response hash and 401" do
      expect(subject).
        to receive(:error!).
        with({ "message" => "Not authorized.", "status"  => 401 }, 401)

      subject.unauthorized!
    end
  end

  describe "#warden" do
    it "returns env['warden']" do
      expect(subject.warden).to eq(subject.env["warden"])
    end
  end
end
