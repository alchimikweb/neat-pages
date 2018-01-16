require 'spec_helper'

describe NeatPages::Helpers::Relation do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with pagination at 1 of 4" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 1,
          :next? => true,
          :next_page => 2,
          :previous? => false,
          :total_pages => 4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"next\" href=\"http://test.dev?page=2\"/>\n"
      end
    end

    context "with pagination at 2 of 4" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 1,
          :next? => true,
          :next_page => 3,
          :previous? => true,
          :previous_page => 1,
          :total_pages => 4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"prev\" href=\"http://test.dev?page=1\"/>\n<link rel=\"next\" href=\"http://test.dev?page=3\"/>\n"
      end
    end

    context "with pagination at 4 of 4" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 4,
          :next? => false,
          :previous? => true,
          :previous_page => 3,
          :total_pages => 4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"prev\" href=\"http://test.dev?page=3\"/>\n"
      end
    end

  end
end
