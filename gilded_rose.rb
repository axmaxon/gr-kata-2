module GildedRose
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

  class RegularItem < Item
    def update_quality
      if @quality > 0
        @sell_in > 0 ? self.decrease_quality(1) : self.decrease_quality(2)
      end

      decrease_sell_in
    end
  end

  class AgedBrie < Item
    def update_quality
      if @quality < 50
        @sell_in > 0 ? increase_quality(1) : increase_quality(2)
      end

      decrease_sell_in
    end
  end

  class Backstage < Item
    def update_quality
      if @quality < 50
        case @sell_in
        when (11..)
          increase_quality(1)
        when (6..10)
          increase_quality(2)
        when (1..5)
          increase_quality(3)
        end
      end

      @quality = 0 if @sell_in <= 0

      decrease_sell_in
    end
  end

  # Является легендарным товаром с неизменяемыми свойствами
  class Sulfuras < Item
    def update_quality
    end
  end

  class Conjured < Item
    def update_quality
      if @quality > 0
        @sell_in > 0 ? decrease_quality(2) : decrease_quality(4)
      end

      decrease_sell_in
    end
  end

  DEFAULT_CLASS = Item
  SPECIALIZED_CLASSES = {
    'Aged Brie' => AgedBrie,
    'Backstage passes to a TAFKAL80ETC concert' => Backstage,
    'Sulfuras, Hand of Ragnaros' => Sulfuras,
    'Conjured Mana Cake' => Conjured
  }

  def self.for(name, sell_in, quality)
    (SPECIALIZED_CLASSES[name] || RegularItem).new(name, sell_in, quality)
  end

  private

  def increase_quality(value)
    value.times do
      @quality += 1 if @quality < 50
    end
  end

  def decrease_quality(value)
    value.times do
      @quality -= 1 if @quality > 0
    end
  end

  def decrease_sell_in
    @sell_in -= 1
  end
end
