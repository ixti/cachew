require "spec_helper"

RSpec.describe Cachew::Hash do
  describe ".new" do
    it "accepts any #to_hash object" do
      storage = double(:to_hash => {})

      described_class.new(storage).fetch(:foo) { :bar }

      expect(storage.to_hash).not_to be_empty
    end

    it "tolerates argument-less call" do
      expect { described_class.new }.not_to raise_error
    end
  end

  describe "#[]" do
    let(:cachew) { described_class.new }

    context "when value is not cahed yet" do
      it "evaluates given block" do
        expect { |b| cachew.fetch :foo, &b }.to yield_control
      end

      it "returns evaluated value" do
        expect(cachew.fetch(:foo) { :bar }).to be :bar
      end
    end

    context "when value was already cached" do
      before { cachew.fetch(:foo) { :cached } }

      it "does not evaluates block" do
        expect { |b| cachew.fetch(:foo, &b) }.not_to yield_control
      end

      it "returns previously cached value" do
        expect(cachew.fetch(:foo) { :bar }).to be :cached
      end
    end

    context "when value with expiration still fresh" do
      before { cachew.fetch(:foo, :ttl => 84) { :cached } }

      it "does not evaluates given block" do
        Timecop.travel 42 do
          expect { |b| cachew.fetch :foo, :ttl => 84, &b }.not_to yield_control
        end
      end

      it "returns previously cached value" do
        Timecop.travel 42 do
          expect(cachew.fetch(:foo, :ttl => 84) { :bar }).to be :cached
        end
      end
    end

    context "when value with expiration became stale" do
      before { cachew.fetch(:foo, :ttl => 21) { :cached } }

      it "evaluates given block" do
        Timecop.travel 42 do
          expect { |b| cachew.fetch :foo, :ttl => 21, &b }.to yield_control
        end
      end

      it "returns evaluated value" do
        Timecop.travel 42 do
          expect(cachew.fetch(:foo, :ttl => 21) { :bar }).to be :bar
        end
      end
    end
  end
end
