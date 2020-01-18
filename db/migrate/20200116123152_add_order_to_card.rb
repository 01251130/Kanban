class AddOrderToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :order, :integer
  end
end
