class GildedRose
  ITEM_HANDLERS = {
    'Aged Brie' => :update_aged_brie,
    'Backstage passes to a TAFKAL80ETC concert' => :update_backstage_pass,
    'Sulfuras, Hand of Ragnaros' => :update_sulfuras,
    'Conjured Mana Cake' => :update_conjured
  }

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item_handler = ITEM_HANDLERS[item.name] || :update_regular_item
      send(item_handler, item)
    end
  end

  private

  def update_regular_item(item)
    if item.quality > 0
      item.sell_in > 0 ? decrease_quality(item, 1) : decrease_quality(item, 2)
    end

    decrease_sell_in(item)
  end

  def update_aged_brie(item)
    if item.quality < 50
      item.sell_in > 0 ? increase_quality(item, 1) : increase_quality(item, 2)
    end

    decrease_sell_in(item)
  end

  def update_backstage_pass(item)
    if item.quality < 50
      case item.sell_in
      when (11..)
        increase_quality(item, 1)
      when (6..10)
        increase_quality(item, 2)
      when (1..5)
        increase_quality(item, 3)
      end
    end

    item.quality = 0 if (..0).include?(item.sell_in)

    decrease_sell_in(item)
  end

  def update_sulfuras(_)
    # Товар имеет неизменяемые свойства
  end

  def update_conjured(item)
    if item.quality > 0
      item.sell_in > 0 ? decrease_quality(item, 2) : decrease_quality(item, 4)
    end

    decrease_sell_in(item)
  end

  def increase_quality(item, value)
    value.times do
      item.quality += 1 if item.quality < 50
    end
  end

  def decrease_quality(item, value)
    value.times do
      item.quality -= 1 if item.quality > 0
    end
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
