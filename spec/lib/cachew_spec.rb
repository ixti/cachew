require "spec_helper"

describe Cachew do
  describe ".new" do
    it "initiates with NullAdapter by default" do
      expect(described_class.new.adapter).to be_a Cachew::Adapters::BaseAdapter
    end

    it "calls Adapters.build_adapter_for with given store" do
      store = { :foo => :bar }
      expect(Cachew::Adapters).to receive(:build_adapter_for).with store
      described_class.new store
    end
  end

  describe "#set" do
    subject(:cachew) { described_class.new.set }
    specify { expect { cachew.adapter.to receive :set } }
  end

  describe "#get" do
    subject(:cachew) { described_class.new.get }
    specify { expect { cachew.adapter.to receive :get } }
  end

  describe "#has?" do
    subject(:cachew) { described_class.new.has? }
    specify { expect { cachew.adapter.to receive :has? } }
  end

  describe "#fetch" do
    let(:cachew) { described_class.new :foo => :bar }

    it "calls has?" do
      expect(cachew).to receive(:has?)
      cachew.fetch(:foo) { :moo }
    end

    context "when adapter has? key" do
      it "calls get" do
        expect(cachew).to receive(:get)
        cachew.fetch(:foo) { :moo }
      end
    end

    context "when adapter does not has? key" do
      it "calls set" do
        expect(cachew).to receive(:set)
        cachew.fetch(:bar) { :moo }
      end
    end
  end
end
