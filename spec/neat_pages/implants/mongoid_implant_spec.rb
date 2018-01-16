require 'spec_helper'

describe NeatPages::Implants::MongoidCriteriaImplant do
  let(:pagination) { double() }
  let(:implant) { Module.new { extend NeatPages::Implants::MongoidCriteriaImplant } }

  describe "#paginate" do
    context "when the pagination isn't initialized" do
      it "raises" do
        expect { implant.paginate(nil) }.to raise_error NeatPages::Uninitalized
      end
    end

    context "when the page is out of bound" do
      before do
        allow(implant).to receive_messages(count: 1)
        allow(pagination).to receive_messages(set_total_items: 1, out_of_bound?: true)
      end

      it "raises" do
        expect { implant.paginate(pagination) }.to raise_error NeatPages::OutOfBound
      end
    end

    context "when asking for a page in bound" do
      before do
        allow(implant).to receive_messages(count: 1, limit: '', offset: implant)
        allow(pagination).to receive_messages(set_total_items: 1, out_of_bound?: false, offset: '', limit: '')
      end

      it { expect(implant.paginate(pagination)).to eql '' }
    end

  end
end

