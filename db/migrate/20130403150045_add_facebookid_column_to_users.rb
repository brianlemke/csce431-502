class AddFacebookidColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebookid, :string
  end
end
