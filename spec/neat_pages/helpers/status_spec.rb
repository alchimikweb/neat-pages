require 'spec_helper'

describe NeatPages::Helpers::Status do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with an empty pagination" do
      before { allow(pagination).to receive_messages(:empty? => true) }

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a pagination out of bound" do
      before do
        allow(pagination).to receive_messages(:empty? => false, :out_of_bound? => true)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a 100 items pagination starting at 20 and having 10 items per page" do
      before do
        allow(pagination).to receive_messages(
          :empty? => false,
          :out_of_bound? => false,
          :offset => 20,
          :per_page => 10,
          :total_items => 100)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">30</span>/<span class="total">100</span></span>'
      end
    end

    context "with a 23 items pagination starting at 20 and having 10 items per page" do
      before do
        allow(pagination).to receive_messages(
          :empty? => false,
          :out_of_bound? => false,
          :offset => 20,
          :per_page => 10,
          :total_items => 23)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">23</span>/<span class="total">23</span></span>'
      end
    end
  end
end
