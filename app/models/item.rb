class Item < ApplicationRecord

   has_one_attached :image

   belongs_to :genr
   has_many :cart_items
   has_many :order_detas

   validates :name, presence: true
   validates :introduction, presence: true
   validates :price, presence: true

end
