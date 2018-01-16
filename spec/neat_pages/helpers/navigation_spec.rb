require 'spec_helper'

describe NeatPages::Helpers::Navigation do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with a pagination that doesn't need pages" do
      before { allow(pagination).to receive_messages(:paginated? => false) }

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a 40 items pagination starting at 20 and having 10 items per page" do
      before do
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
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4"><li class="move previous "><a data-page="2" href="http://test.dev?page=2" class="previous">&laquo; Previous</a></li><li class="page"><a data-page="1" href="http://test.dev?page=1">1</a></li><li class="page"><a data-page="2" href="http://test.dev?page=2">2</a></li><li class="page selected"><a data-page="3" href="http://test.dev?page=3">3</a></li><li class="page"><a data-page="4" href="http://test.dev?page=4">4</a></li><li class="move next "><a data-page="4" href="http://test.dev?page=4" class="next">Next &raquo;</a></li></ul>'
      end
    end

    context "with a 40 items pagination starting at 30 and having 10 items per page" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 3,
          :next? => false,
          :next_page => nil,
          :offset => 30,
          :per_page => 10,
          :previous? => true,
          :previous_page => 2,
          :total_items => 40,
          :total_pages => 4)
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4"><li class="move previous "><a data-page="2" href="http://test.dev?page=2" class="previous">&laquo; Previous</a></li><li class="page"><a data-page="1" href="http://test.dev?page=1">1</a></li><li class="page"><a data-page="2" href="http://test.dev?page=2">2</a></li><li class="page selected"><a data-page="3" href="http://test.dev?page=3">3</a></li><li class="page"><a data-page="4" href="http://test.dev?page=4">4</a></li><li class="move next disabled"><a data-page="#" href="#" class="next">Next &raquo;</a></li></ul>'
      end
    end

    context "with a 200 items pagination starting at 110 and having 10 items per page" do
      before do
        allow(pagination).to receive_messages(
          :paginated? => true,
          :current_page => 12,
          :next? => true,
          :next_page => 13,
          :offset => 110,
          :per_page => 10,
          :previous? => true,
          :previous_page => 11,
          :total_items => 200,
          :total_pages => 20)
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="200" data-total-pages="20">'+
          '<li class="move previous "><a data-page="11" href="http://test.dev?page=11" class="previous">&laquo; Previous</a></li>'+
          '<li class="page" style="display:none"><a data-page="1" href="http://test.dev?page=1">1</a></li>'+
          '<li class="page" style="display:none"><a data-page="2" href="http://test.dev?page=2">2</a></li>'+
          '<li class="page" style="display:none"><a data-page="3" href="http://test.dev?page=3">3</a></li>'+
          '<li class="page" style="display:none"><a data-page="4" href="http://test.dev?page=4">4</a></li>'+
          '<li class="page" style="display:none"><a data-page="5" href="http://test.dev?page=5">5</a></li>'+
          '<li class="page" style="display:none"><a data-page="6" href="http://test.dev?page=6">6</a></li>'+
          '<li class="page" style="display:none"><a data-page="7" href="http://test.dev?page=7">7</a></li>'+
          '<li class="page"><a data-page="8" href="http://test.dev?page=8">8</a></li>'+
          '<li class="page"><a data-page="9" href="http://test.dev?page=9">9</a></li>'+
          '<li class="page"><a data-page="10" href="http://test.dev?page=10">10</a></li>'+
          '<li class="page"><a data-page="11" href="http://test.dev?page=11">11</a></li>'+
          '<li class="page selected"><a data-page="12" href="http://test.dev?page=12">12</a></li>'+
          '<li class="page"><a data-page="13" href="http://test.dev?page=13">13</a></li>'+
          '<li class="page"><a data-page="14" href="http://test.dev?page=14">14</a></li>'+
          '<li class="page"><a data-page="15" href="http://test.dev?page=15">15</a></li>'+
          '<li class="page"><a data-page="16" href="http://test.dev?page=16">16</a></li>'+
          '<li class="page"><a data-page="17" href="http://test.dev?page=17">17</a></li>'+
          '<li class="page" style="display:none"><a data-page="18" href="http://test.dev?page=18">18</a></li>'+
          '<li class="page" style="display:none"><a data-page="19" href="http://test.dev?page=19">19</a></li>'+
          '<li class="page" style="display:none"><a data-page="20" href="http://test.dev?page=20">20</a></li>'+
          '<li class="move next "><a data-page="13" href="http://test.dev?page=13" class="next">Next &raquo;</a></li></ul>'
      end
    end

  end
end
