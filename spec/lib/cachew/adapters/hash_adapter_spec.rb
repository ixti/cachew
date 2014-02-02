require "spec_helper"

describe Cachew::Adapters::HashAdapter do
  let(:adapter) { described_class.new({}) }

  describe "#set" do
    it "returns back given value" do
      expect(adapter.set(:foo, :bar)).to be :bar
    end

    it "sets value in the underlying store Hash" do
      adapter.set(:foo, :bar)
      expect(adapter.store).to eq :foo => :bar
    end
  end

  describe "#get" do
    it "returns nil if value does not exists" do
      expect(adapter.get(:foo)).to be_nil
    end

    it "returns saved value if exists" do
      adapter.store[:foo] = :bar
      expect(adapter.get(:foo)).to be :bar
    end
  end

  describe "#has?" do
    it "returns true even if stored value is nil" do
      adapter.store[:foo] = nil
      expect(adapter.has?(:foo)).to be_true
    end
  end
end
