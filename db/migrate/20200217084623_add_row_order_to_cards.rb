class AddRowOrderToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :row_order, :integer
  end
end
