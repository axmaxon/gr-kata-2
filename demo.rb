require_relative './gilded_rose'
include GildedRose

puts "OMGHAI!"

items = [
  GildedRose.for(name="+5 Dexterity Vest", sell_in=10, quality=20),
  GildedRose.for(name="Aged Brie", sell_in=2, quality=0),
  GildedRose.for(name="Elixir of the Mongoose", sell_in=5, quality=7),
  GildedRose.for(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
  GildedRose.for(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
  GildedRose.for(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
  GildedRose.for(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
  GildedRose.for(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
  GildedRose.for(name="Conjured Mana Cake", sell_in=3, quality=6),
  GildedRose.for(name="Conjured Mana Cake", sell_in=0, quality=3)
]

days = 2

if ARGV.size > 0
  days = ARGV[0].to_i + 1
end

(0...days).each do |day|
  puts "-------- day #{day} --------"
  puts "name, sellIn, quality"

  items.each do |item|
    puts item
    item.update_quality
  end

  puts
end
