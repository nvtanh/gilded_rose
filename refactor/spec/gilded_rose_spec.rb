require "rspec"
require_relative "../lib/gilded_rose"

describe "#update_quality" do
  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }

    context "Normal item" do
      before do
        @item = NormalItem.new(initial_sell_in, initial_quality)
        update_quality([@item])
      end

      context "before sell date" do
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 1) }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 2) }
      end

      context "after sell date" do
        let(:initial_sell_in) { -5 }
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 2) }
      end

      context "quality is zero" do
        let(:initial_quality) { 0 }
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal 0 }
      end
    end

    context "Aged Brie" do
      before do
        @item = AgedBrie.new(initial_sell_in, initial_quality)
        update_quality([@item])
      end

      context "before sell date" do
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 1) }

        context "quality is maximum" do
          let(:initial_quality) {50}
          it { expect(@item.quality).to equal 50 }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) {0}

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 2) }

        context "quality is near maximum" do
          let(:initial_quality) {49}
          it { expect(@item.quality).to equal 50 }
        end

        context "quality is maximum" do
          let(:initial_quality) {50}
          it { expect(@item.quality).to equal 50 }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) {-5}

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 2) }

        context "quality is near maximum" do
          let(:initial_quality) {49}
          it { expect(@item.quality).to equal 50 }
        end

        context "quality is maximum" do
          let(:initial_quality) {50}
          it { expect(@item.quality).to equal 50 }
        end
      end
    end

    context "Sulfuras" do
      let(:initial_quality) { 80 }

      before do
        @item = Sulfuras.new(initial_sell_in, initial_quality)
        update_quality([@item])
      end

      context "before sell date" do
        it { expect(@item.sell_in).to equal initial_sell_in }
        it { expect(@item.quality).to equal initial_quality }
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }
        it { expect(@item.sell_in).to equal initial_sell_in }
        it { expect(@item.quality).to equal initial_quality }
      end

      context "after sell date" do
        let(:initial_sell_in) { -5 }
        it { expect(@item.sell_in).to equal initial_sell_in }
        it { expect(@item.quality).to equal initial_quality }
      end
    end

    context "Backstage pass" do
      before do
        @item = Backstage.new(initial_sell_in, initial_quality)
        update_quality([@item])
      end

      context "long before sell date" do
        let(:initial_sell_in) { 11 }

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 1) }

        context "quality is maximum" do
          let(:initial_quality) { 50 }
          it { expect(@item.quality).to equal 50 }
        end
      end

      context "medium close to sell date" do
        let(:initial_sell_in) { 10 }

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 2) }

        context "quality is near maximum" do
          let(:initial_quality) { 49 }
          it { expect(@item.quality).to equal 50 }
        end

        context "quality is maximum" do
          let(:initial_quality) { 50 }
          it { expect(@item.quality).to equal 50 }
        end
      end

      context "very close to sell date" do
        let(:initial_sell_in) { 5 }

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality + 3) }

        context "quality is near maximum" do
          let(:initial_quality) { 48 }
          it { expect(@item.quality).to equal 50 }
        end

        context "quality is maximum" do
          let(:initial_quality) { 50 }
          it { expect(@item.quality).to equal 50 }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        it { expect(@item.quality).to equal 0 }
      end

      context "after sell date" do
        let(:initial_sell_in) { -5 }

        it { expect(@item.quality).to equal 0 }
      end
    end

    context "Conjured item" do
      before do
        @item = Conjured.new(initial_sell_in, initial_quality)
        update_quality([@item])
      end

      context "before sell date" do
        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 2) }

        context "quality is near minimum" do
          let(:initial_quality) {1}
          it { expect(@item.quality).to equal 0 }
        end

        context "quality is zero" do
          let(:initial_quality) {0}
          it { expect(@item.quality).to equal 0 }
        end
      end

      context "on sell date" do
        let(:initial_sell_in) { 0 }

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 4) }

        context "quality is near minimum" do
          let(:initial_quality) {3}
          it { expect(@item.quality).to equal 0 }
        end

        context "quality is zero" do
          let(:initial_quality) {0}
          it { expect(@item.quality).to equal 0 }
        end
      end

      context "after sell date" do
        let(:initial_sell_in) { -5 }

        it { expect(@item.sell_in).to equal (initial_sell_in - 1) }
        it { expect(@item.quality).to equal (initial_quality - 4) }

        context "quality is near minimum" do
          let(:initial_quality) {3}
          it { expect(@item.quality).to equal 0 }
        end

        context "quality is zero" do
          let(:initial_quality) {0}
          it { expect(@item.quality).to equal 0 }
        end
      end
    end
  end

  context "with multiple items" do
    let(:items) {
      [
        NormalItem.new(5, 10),
        AgedBrie.new(5, 10),
        Sulfuras.new(5, 80),
        Backstage.new(5, 10),
        Conjured.new(5, 10),
      ]
    }

    before { update_quality(items) }

    it { expect(items[0].sell_in).to equal 4 }
    it { expect(items[0].quality).to equal 9 }

    it { expect(items[1].sell_in).to equal 4 }
    it { expect(items[1].quality).to equal 11 }

    it { expect(items[2].sell_in).to equal 5 }
    it { expect(items[2].quality).to equal 80 }

    it { expect(items[3].sell_in).to equal 4 }
    it { expect(items[3].quality).to equal 13 }

    it { expect(items[4].sell_in).to equal 4 }
    it { expect(items[4].quality).to equal 8 }
  end
end
