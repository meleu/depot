class Product < ApplicationRecord
  has_one_attached :image

  # TODO: (meleu) have a better understanding about this.
  # broadcast changes to the product model to any clients that are listening
  after_commit -> { broadcast_refresh_later_to "products" }
end
