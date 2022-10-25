class CreateOrderDeta < ActiveRecord::Migration[6.1]
  def change
    create_table :order_deta do |t|

      t.integer :item_id
      t.integer :order_id
      t.integer :amount
      t.integer :purchase_price
      t.integer :production_status, default: 0
      t.timestamps
    end
  end
end
