class Item
  attr_reader :id, :name, :description, :count, :category, :user_id

  def initialize(data)
    @id = data[:id]
    @name = data[:attributes][:name]
    @description = data[:attributes][:description]
    @count = data[:attributes][:count]
    @category = Item.category_list[data[:attributes][:category]]
    @user_id = data[:attributes][:user_id]
  end

  def self.category_list
    [
      "Tents",
      "Sleeping Bag",
      "Stoves, Grills & Fuel",
      "Cookware",
      "Dishes",
      "Ropes",
      "Harnesses",
      "Belay & Rappel",
      "Crash Pads",
      "Quickdraws"
    ]
  end
end
