class AddVerifiedToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :verified, :boolean, default: false
  end
end
