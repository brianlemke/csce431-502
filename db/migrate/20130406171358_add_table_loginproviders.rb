class AddTableLoginproviders < ActiveRecord::Migration
  def up
  	create_table :loginproviders do |t|
  		t.integer :user_id
  		t.string :provider
  		t.string :loginid
  	end
  end

  def down
  	drop_table :loginproviders
  end
end
