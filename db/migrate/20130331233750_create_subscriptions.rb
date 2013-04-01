class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :organization_id]
  end
end
