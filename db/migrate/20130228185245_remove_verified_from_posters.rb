class RemoveVerifiedFromPosters < ActiveRecord::Migration
  def up
    remove_column :posters, :verified
  end

  def down
    add_column :posters, :verified, :boolean
  end
end
