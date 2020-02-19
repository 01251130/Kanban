class Card < ApplicationRecord
  include RankedModel
  ranks :row_order, with_same: :list_id

  belongs_to :list

  validates :title, length:{in: 1..255}
  validates :memo, length:{maximum: 1000}
end
