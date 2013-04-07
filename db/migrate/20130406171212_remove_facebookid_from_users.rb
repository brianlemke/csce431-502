class RemoveFacebookidFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :facebookid
  end

  def down
    add_column :users, :facebookid, :string
  end
end
