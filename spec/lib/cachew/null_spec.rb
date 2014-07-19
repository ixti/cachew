require "spec_helper"

RSpec.describe Cachew::Null do
  let(:cachew) { described_class.new }

  describe ".new" do
    it "returns Singleton instance" do
      expect(cachew).to be described_class.new
    end
  end

  describe "#[]" do
    it "always evaluates given block" do
      expect { |b| cachew.fetch(:foo, &b) }.to yield_control
    end

    it "returns value of given block" do
      [:foo, :bar, :baz].each do |val|
        expect(cachew.fetch(:foo) { val }).to be val
      end
    end
  end
end
