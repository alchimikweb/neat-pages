require 'spec_helper'

describe NeatPages::Helpers::MoreButton do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with an empty pagination" do
      before { allow(pagination).to receive_messages(:paginated? => false) }

      let(:builder) { NeatPages::Helpers::MoreButton.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end


    context "with pagination at 1 of 4" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :next? => true,
          :next_page => 2,
          :total_pages => 4)
      end

      let(:builder) { NeatPages::Helpers::MoreButton.new(pagination, request_mock) }

      specify "when generating button" do
        expect(builder.generate('plus', 'fin')).to eql '<div id="neat-pages-more-button" data-next-page="2" data-total-pages="4">' +
          '<a href="http://test.dev?page=2">plus</a><div class="over">fin</div></div>'
      end
    end
  end
end
