class AddColumnOrderIdToNote < ActiveRecord::Migration
  def self.up
    add_column :notes, :order_id, :integer
  end

  def self.down
    remove_column :notes,:order_id, :integer
  end

end
