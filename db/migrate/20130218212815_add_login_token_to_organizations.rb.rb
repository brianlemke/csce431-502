class AddLoginTokenToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :login_token, :string
    add_index :organizations, :login_token
  end
end
