class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :email
      t.string :name
      t.string :description
      t.string :password_digest

      t.timestamps
    end

    add_index :organizations, :email, unique: true
  end
end
