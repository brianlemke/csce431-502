class AddOrganizationToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :organization_id, :string
    add_index :posters, :organization_id
  end
end
