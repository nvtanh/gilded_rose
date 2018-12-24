def update_quality(items)
  items.each do |item|
    item.update
  end
end


######### DO NOT CHANGE #########

Item = Struct.new(:name, :sell_in, :quality)

######### DO NOT CHANGE #########

class NormalItem < Item
  QUALITY_MAXIMUM = 50
  QUALITY_MIXIMUM = 0

  def initialize sell_in, quality
    self.name = "Normal Item"
    self.sell_in = sell_in
    self.quality = quality
  end

  def update
    update_quality
    self.sell_in -= 1
  end

  def update_quality
    return quality_jump(-2) if sell_in <= 0
    quality_jump(-1)
  end

  def quality_jump amount
    self.quality += amount
    self.quality = QUALITY_MAXIMUM if self.quality > QUALITY_MAXIMUM
    self.quality = QUALITY_MIXIMUM if self.quality < QUALITY_MIXIMUM
  end
end

class AgedBrie < NormalItem
  def initialize sell_in, quality
    super
    self.name = "Aged Brie"
  end

  def update_quality
    return quality_jump(2) if self.sell_in <= 0
    quality_jump(1)
  end
end

class Sulfuras < NormalItem
  def initialize sell_in, quality
    super
    self.name = "Sulfuras, Hand of Ragnaros"
  end

  def update ; end
end

class Backstage < NormalItem
  def initialize sell_in, quality
    super
    self.name = "Backstage passes to a TAFKAL80ETC concert"
  end

  def update_quality
    return self.quality = 0 if self.sell_in <= 0
    return quality_jump(3) if self.sell_in <= 5
    return quality_jump(2) if self.sell_in <= 10
    return quality_jump(1) if self.sell_in > 10
  end
end

class Conjured < NormalItem
  def initialize sell_in, quality
    super
    self.name = "Conjured"
  end

  def update_quality
    return quality_jump(-4) if sell_in <= 0
    quality_jump(-2)
  end
end
