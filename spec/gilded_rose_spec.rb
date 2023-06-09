require_relative '../gilded_rose'
include GildedRose

RSpec.describe GildedRose::RegularItem do
  describe '#update_quality' do
    let(:name) { '+5 Dexterity Vest' }
    let(:regular_item_1) { GildedRose.for(name, 2, 25) }
    let(:regular_item_2) { GildedRose.for(name, 0, 25) }
    let(:regular_item_3) { GildedRose.for(name, -1, 25) }
    let(:regular_item_4) { GildedRose.for(name, 2, 0) }
    let(:regular_item_5) { GildedRose.for(name, -1, 1) }

    before do
      items = [regular_item_1, regular_item_2, regular_item_3, regular_item_4, regular_item_5]
      items.each { |item| item.update_quality }
    end

    context 'when sell_in is greater than 0' do
      it 'decreases sell_in by 1 and decreases quality by 1' do
        expect(regular_item_1).to have_attributes(sell_in: 1, quality: 24)
      end
    end

    context 'when sell_in is 0 or less' do
      it 'decreases sell_in by 1 and decreases quality by 2' do
        expect(regular_item_2).to have_attributes(sell_in: -1, quality: 23)
        expect(regular_item_3).to have_attributes(sell_in: -2, quality: 23)
      end

      context 'when minimum quality is reached' do
        it 'decreases sell_in by 1 and does not decrease quality below 0' do
          expect(regular_item_5).to have_attributes(sell_in: -2, quality: 0)
        end
      end
    end

    context 'when quality is 0' do
      it 'decreases sell_in and not change quality' do
        expect(regular_item_4).to have_attributes(sell_in: 1, quality: 0)
      end
    end
  end
end

RSpec.describe GildedRose::AgedBrie do
  describe '#update_quality' do
    name = 'Aged Brie'
    let(:aged_brie_1) { GildedRose.for(name, 2, 25) }
    let(:aged_brie_2) { GildedRose.for(name, 2, 50) }
    let(:aged_brie_3) { GildedRose.for(name, 0, 25) }
    let(:aged_brie_4) { GildedRose.for(name, -1, 25) }
    #
    before do
      items = [aged_brie_1, aged_brie_2, aged_brie_3, aged_brie_4]
      items.each { |item| item.update_quality }
    end
    #
    context 'when sell_in is greater than 0' do
      it 'decreases sell_in by 1 and increases quality by 1' do
        expect(aged_brie_1).to have_attributes(sell_in: 1, quality: 26)
      end
    end

    context 'when quality reaches maximum value (50)' do
      it 'decreases sell_in by 1 and does not change quality' do
        expect(aged_brie_2).to have_attributes(sell_in: 1, quality: 50)
      end
    end

    context 'when sell_in is 0 or less' do
      it 'decreases sell_in by 1 and increases quality by 2' do
        expect(aged_brie_3).to have_attributes(sell_in: -1, quality: 27)
        expect(aged_brie_4).to have_attributes(sell_in: -2, quality: 27)
      end
    end
  end
end

RSpec.describe GildedRose::BackstagePass do
  describe '#update_quality' do
    let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
    let(:backstage_passes_1) { GildedRose.for(name, 11, 25) }
    let(:backstage_passes_2) { GildedRose.for(name, 10, 25) }
    let(:backstage_passes_3) { GildedRose.for(name, 6, 25) }
    let(:backstage_passes_4) { GildedRose.for(name, 5, 25) }
    let(:backstage_passes_5) { GildedRose.for(name, 1, 25) }
    let(:backstage_passes_6) { GildedRose.for(name, 0, 25) }
    let(:backstage_passes_7) { GildedRose.for(name, -1, 25) }
    let(:backstage_passes_8) { GildedRose.for(name, 7, 49) }
    let(:backstage_passes_9) { GildedRose.for(name, 2, 48) }

    before do
      items = [backstage_passes_1, backstage_passes_2, backstage_passes_3,
               backstage_passes_4, backstage_passes_5, backstage_passes_6,
               backstage_passes_7, backstage_passes_8, backstage_passes_9]

      items.each { |item| item.update_quality }
    end

    context 'when sell_in is greater than 10' do
      it 'decreases sell_in by 1 and increases quality by 1' do
        expect(backstage_passes_1).to have_attributes(sell_in: 10, quality: 26)
      end
    end

    context 'when sell_in in the range 10..6' do
      it 'decreases sell_in by 1 and increases quality by 2' do
        expect(backstage_passes_2).to have_attributes(sell_in: 9, quality: 27)
        expect(backstage_passes_3).to have_attributes(sell_in: 5, quality: 27)
      end

      context 'when maximum quality is reached' do
        it 'does not increase quality beyond 50' do
          expect(backstage_passes_8).to have_attributes(sell_in: 6, quality: 50)
        end
      end
    end

    context 'when sell_in in the range 5..1' do
      it 'decreases sell_in by 1 and increases quality by 3' do
        expect(backstage_passes_4).to have_attributes(sell_in: 4, quality: 28)
        expect(backstage_passes_5).to have_attributes(sell_in: 0, quality: 28)
      end
      context 'when maximum quality is reached' do
        it 'does not increase quality beyond 50' do
          expect(backstage_passes_9).to have_attributes(sell_in: 1, quality: 50)
        end
      end
    end

    context 'when sell_in is 0 or less' do
      it 'decreases sell_in by 1 and sets quality to 0' do
        expect(backstage_passes_6).to have_attributes(sell_in: -1, quality: 0)
        expect(backstage_passes_7).to have_attributes(sell_in: -2, quality: 0)
      end
    end
  end
end

RSpec.describe GildedRose::Sulfuras do
  describe '#update_quality' do
    let(:name) { 'Sulfuras, Hand of Ragnaros' }
    let(:sulfuras_1) { GildedRose.for(name, 100, 80) }
    let(:sulfuras_2) { GildedRose.for(name, 0, 80) }
    let(:sulfuras_3) { GildedRose.for(name, -100, 80) }

    before do
      items = [sulfuras_1, sulfuras_2, sulfuras_3]
      items.each { |item| item.update_quality }
    end

    context 'when sell_in in the range -100..100' do
      it 'does not change sell_in and does not change quality' do
        expect(sulfuras_1).to have_attributes(sell_in: 100, quality: 80)
        expect(sulfuras_2).to have_attributes(sell_in: 0, quality: 80)
        expect(sulfuras_3).to have_attributes(sell_in: -100, quality: 80)
      end
    end
  end
end

RSpec.describe GildedRose::Conjured do
  describe '#update_quality' do
    let(:name) { 'Conjured Mana Cake' }
    let(:conjured_1) { GildedRose.for(name, 2, 25) }
    let(:conjured_2) { GildedRose.for(name, 0, 25) }
    let(:conjured_3) { GildedRose.for(name, -1, 25) }
    let(:conjured_4) { GildedRose.for(name, 0, 3) }
    let(:conjured_5) { GildedRose.for(name, 2, 0) }

    before do
      items = [conjured_1, conjured_2, conjured_3,
               conjured_4, conjured_5]

      items.each { |item| item.update_quality }
    end

    context 'when sell_in is greater than 0' do
      it 'decreases sell_in by 1 and decreases quality by 2' do
        expect(conjured_1).to have_attributes(sell_in: 1, quality: 23)
      end
    end

    context 'when sell_in is 0 or less' do
      it 'decreases sell_in by 1 and decreases quality by 4' do
        expect(conjured_2).to have_attributes(sell_in: -1, quality: 21)
        expect(conjured_3).to have_attributes(sell_in: -2, quality: 21)
      end

      context 'when minimum quality is reached' do
        it 'decreases sell_in by 1 and does not decrease quality below 0' do
          expect(conjured_4).to have_attributes(sell_in: -1, quality: 0)
        end
      end
    end

    context 'when quality is 0' do
      it 'decreases sell_in and not change quality' do
        expect(conjured_5).to have_attributes(sell_in: 1, quality: 0)
      end
    end
  end
end

RSpec.describe GildedRose do
  describe '.for' do
    context 'when creating an item' do
      it 'returns the correct specialized item class based on name' do
        item = GildedRose.for('Aged Brie', 5, 10)
        expect(item).to be_instance_of(GildedRose::AgedBrie)
      end

      it 'returns a RegularItem if no specialized class is found' do
        item = GildedRose.for('Some Item', 5, 10)
        expect(item).to be_instance_of(GildedRose::RegularItem)
      end
    end
  end
end
