require 'spec_helper'

describe NeatPages::Helpers do
  include ViewHelpers

  let(:pagination) { double() }
  let(:views) { Module.new { extend NeatPages::Helpers } }

  describe "#neat_pages_ajax_items" do
    before { allow(views).to receive_messages(render: '[html_list_of_items]') }

    specify "when rendering the ajax items" do
      expect(views.neat_pages_ajax_items('items')).to eql '<div id="neat-pages-ajax-wrapper" class="first-load">[html_list_of_items]</div>'
    end

    specify "when rendering the ajax items for a table" do
      expect(views.neat_pages_ajax_items('items', wrapper: 'tbody')).to eql '<tbody id="neat-pages-ajax-wrapper" class="first-load">[html_list_of_items]</tbody>'
    end
  end

  describe "#neat_pages_more_button" do
    before do
      allow(views).to receive_messages(request: request_mock(host: 'testview.dev'))

      allow(pagination).to receive_messages(
          :paginated? => true,
          :next? => true,
          :next_page => 2,
          :total_pages => 4)

      allow(views).to receive_messages(pagination: pagination)
    end

    specify "when rendering the more button" do
      expect(views.neat_pages_more_button).to eql '<div id="neat-pages-more-button" data-next-page="2" data-total-pages="4">' +
        '<a href="http://testview.dev?page=2">More items</a><div class="over">No more items</div></div>'
    end
  end

  describe "#neat_pages_navigation" do
    before do
      allow(views).to receive_messages(request: request_mock(host: 'testview.dev'))

      allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 3,
          :next? => true,
          :next_page => 4,
          :offset => 20,
          :per_page => 10,
          :previous? => true,
          :previous_page => 2,
          :total_items => 40,
          :total_pages => 4)

      allow(views).to receive_messages(pagination: pagination)
    end

    specify "when rendering the navigation" do
      expect(views.neat_pages_navigation).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4">' +
        '<li class="move previous "><a data-page="2" href="http://testview.dev?page=2" class="previous">&laquo; Previous</a></li>' +
        '<li class="page"><a data-page="1" href="http://testview.dev?page=1">1</a></li>' +
        '<li class="page"><a data-page="2" href="http://testview.dev?page=2">2</a></li>' +
        '<li class="page selected"><a data-page="3" href="http://testview.dev?page=3">3</a></li>' +
        '<li class="page"><a data-page="4" href="http://testview.dev?page=4">4</a></li>' +
        '<li class="move next "><a data-page="4" href="http://testview.dev?page=4" class="next">Next &raquo;</a></li></ul>'
    end
  end

  describe "#neat_pages_link_relation_tags" do
    before do
      allow(views).to receive_messages(request: request_mock(host: 'testview.dev'))

      allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 3,
          :next? => true,
          :next_page => 4,
          :previous? => true,
          :previous_page => 2,
          :total_pages => 4)

      allow(views).to receive_messages(pagination: pagination)
    end

    specify "when rendering the relations" do
      expect(views.neat_pages_link_relation_tags).to eql "<link rel=\"prev\" href=\"http://testview.dev?page=2\"/>\n<link rel=\"next\" href=\"http://testview.dev?page=4\"/>\n"
    end
  end

  describe "#neat_pages_status" do
    before do
      allow(views).to receive_messages(request: request_mock)

      allow(pagination).to receive_messages(
          :empty? => false,
          :out_of_bound? => false,
          :offset => 20,
          :per_page => 10,
          :total_items => 100)

      allow(views).to receive_messages(pagination: pagination)
    end

    specify "when rendering the status" do
      expect(views.neat_pages_status).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">30</span>/<span class="total">100</span></span>'
    end
  end
end
