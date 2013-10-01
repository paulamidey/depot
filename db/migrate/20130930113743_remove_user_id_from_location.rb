class RemoveUserIdFromLocation < ActiveRecord::Migration

  def self.up
    remove_column :locations, :user_id, :integer
  end

end
