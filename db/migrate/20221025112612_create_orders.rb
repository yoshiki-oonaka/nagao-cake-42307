class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.integer :amount
      t.integer :postage
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :order_status, default: 0
      t.integer :payment_method, default: 0
      t.timestamps
    end
  end
end
