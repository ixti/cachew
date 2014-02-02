require "spec_helper"

describe Cachew::Adapters do
  describe ".build_adapter_for" do
    context "with Hash instance" do
      it "returns HashAdapter" do
        adapter = described_class.build_adapter_for :foo => :bar
        expect(adapter).to be_a Cachew::Adapters::HashAdapter
      end
    end

    context "with instance of BaseAdapter" do
      it "returns adapter as is" do
        adapter = Cachew::Adapters::HashAdapter.new :foo => :bar
        expect(described_class.build_adapter_for adapter).to be adapter
      end
    end

    it "returns NullAdapter if can't find better candidate" do
      expect(described_class.build_adapter_for "test")
        .to be_a Cachew::Adapters::NullAdapter
    end
  end
end
