require "spec_helper"

describe Cachew::Adapters::NullAdapter do
  let(:adapter) { described_class.new }

  describe "#set" do
    it "returns back given value" do
      expect(adapter.set(:foo, :bar)).to be :bar
    end
  end

  describe "#get" do
    it "always returns nil" do
      adapter.set(:foo, :bar)
      expect(adapter.get :foo).to be_nil
    end
  end

  describe "#has?" do
    it "always returns false" do
      adapter.set(:foo, :bar)
      expect(adapter.has? :foo).to be_false
    end
  end
end
